import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/page/home/home_page.dart';
import 'package:tuoc/page/login/login_page.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/account_util.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Timer _splashScreen;

  @override
  void initState() {
    super.initState();

    _splashScreen = new Timer(Duration(seconds: 2), () {
      AccountUtil.getAccessToken().then((token) {
        if (token != null)
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (_) => HomePage()));
        else
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (_) => LoginPage()));
      });
    });
  }

  @override
  void dispose() {
    _splashScreen.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeService(context);
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/icons/bg_splash.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'TUORCA',
              style: TextStyle(
                color: Color(0xffC6002C),
                fontSize: SizeService.getFontSize(175),
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            Text(
              'TU Orthopaedic\nCalendar',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: SizeService.getFontSize(75),
                fontWeight: FontWeight.w600,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
