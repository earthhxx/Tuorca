import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/login/login.dart';
import 'package:tuoc/page/home/home_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/alert.dart';
import 'package:tuoc/util/database_util.dart';

import 'login_page.dart';

class LoginPresenter extends BasePresenter<LoginPage> {
  Api _api;

  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool isFake;
  String versionCode;

  LoginPresenter(State<LoginPage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();

    versionCode = await _getVersionCode();
    var data = await DatabaseUtil().selectAllData(dbName: 'master_data');
    isFake = data[0]['is_fake'][versionCode];

    loaded();
  }

  _gotoHomePage() {
    Navigator.pushReplacement(
        state.context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  Future<String> _getVersionCode() async {
    String platformVersion;
    try {
      platformVersion = "Version : 1.0.0 (20)";
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    print(platformVersion);
    return platformVersion;
  }

  onSubmit() async {
    await _validateField();
  }

  _validateField() async {
    try {
      if (usernameCtrl.text.isEmpty) {
        throw ('Please enter your email.');
      }
      if (passwordCtrl.text.isEmpty) {
        throw ('Please enter your password.');
      }

      await _letLogin();
    } catch (e) {
      Alert(
        state.context,
        message: '$e',
      );
    }
  }

  _letLogin() async {
    showLoadingView();
    _api = Api<LoginModel>();

    var res = await _api.login({
      "username": usernameCtrl.text,
      "password": passwordCtrl.text,
      "login_type": "member",
    });

    hideLoadingView();

    if (res.fail == null) {
      LoginModel model = res.success;
      if (model.statusCode == 200) {
        await AccountUtil.saveAccessToken(model.data.access_token);
        await AccountUtil.getProfile();
        _gotoHomePage();
      } else {
        _loginFail(model.message);
      }
    } else {
      print('fail');
      _loginFail(res.fail.message);
    }
  }

  _loginFail(String message) {
    Alert(
      state.context,
      message: message,
    );
  }
}