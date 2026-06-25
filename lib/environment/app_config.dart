import 'package:flutter/cupertino.dart';

class AppConfig extends InheritedWidget {
  final String appName;
  final String baseUrl;
  final Widget child;

  AppConfig({
    @required this.appName,
    @required this.baseUrl,
    @required this.child,
  }) {
    print('set app config');
  }

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
