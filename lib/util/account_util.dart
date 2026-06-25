import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuoc/model/my_profile/my_profile.dart';
import 'package:tuoc/service/api.dart';

class AccountUtil {
  static Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  static Future<String> getAccountIdByToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Map data = _decodeJWT(pref.get('access_token'));

    return data['account_id'];
  }

  static saveAccessToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('access_token', token);
  }

  static Future<void> removeAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('access_token');
  }

  static Future<List<MyProfileDataModel>> getProfile() async {
    Api api = Api<MyProfileModel>();

    var res = await api.getMyProfile({});
    // print("getProfile =${res.success}");
    if (res.fail == null) {
      MyProfileModel model = res.success;
      if (model.statusCode == 200) {
        // print(model.data[0].image_profile);
        await saveImageProfile(model.data[0].image_profile);

        return model.data;
      }
    }

    return null;
  }

  static saveImageProfile(String imagePath) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('image_profile', imagePath);
  }

  static removeImageProfile(String imagePath) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('image_profile');
  }

  static Future<String> getImageProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('image_profile');
  }

  static _decodeJWT(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
