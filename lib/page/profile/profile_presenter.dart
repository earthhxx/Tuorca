import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/my_profile/my_profile.dart';
import 'package:tuoc/page/edit_profile/edit_profile_page.dart';
import 'package:tuoc/page/login/login_page.dart';
import 'package:tuoc/page/profile/profile_page.dart';
import 'package:tuoc/util/account_util.dart';
import 'package:tuoc/util/loading.dart';

class ProfilePresenter extends BasePresenter<ProfilePage> {
  List<MyProfileDataModel> data = [];
  String versionApp;

  ProfilePresenter(State<ProfilePage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getProfile();
    versionApp = "Version : 1.0.0 (20)";
    Loading(state.context).hide();
    loaded();
  }

  // Future<String> _getVersionCode() async {
  //   String projectCode;
  //   String projectVersion;
  //   String appID;
  //   try {
  //     projectCode = await GetVersion.projectCode;
  //     projectVersion = await GetVersion.projectVersion;
  //     appID = await GetVersion.appID;
  //   } on PlatformException {
  //     appID = 'Failed to get platform version.';
  //   }
  //
  //   // print(GetVersion);
  //   return ("Version : ${1.0.0} (${20})");
  // }

  Future<void> _getProfile() async {
    data = [];
    var res = await AccountUtil.getProfile();
    setState(() {
      data = res;
    });
  }

  Future<void> gotoEditProfile() async {
    await Navigator.push(
        state.context, CupertinoPageRoute(builder: (_) => EditProfilePage()));
    _initPage();
  }

  logout() async {
    await AccountUtil.removeAccessToken();
    Navigator.popUntil(state.context, (r) => r.isFirst);
    Navigator.pushReplacement(
        state.context, MaterialPageRoute(builder: (_) => LoginPage()));
  }
}