// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tuoc/environment/app_config.dart';
import 'package:tuoc/page/splash_screen/splash_screen_page.dart';
import 'package:tuoc/service/navigation_service.dart';
import 'package:tuoc/util/app_util.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  var appConfig = AppConfig(
    appName: 'TU Orthopedic Calendar',
    baseUrl: 'https://tu-api.zigmanice.xyz',
    child: MyApp(),
  );

  await AppUtil.getMasterData();
  // FirebaseCrashlytics  ./.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(appConfig);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: AppConfig.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
        primaryColor: Color(0xff3C95B5),
        splashColor: Color(0xff9FDFF8),
      ),
      home: SplashScreenPage(),
    );
  }
}
