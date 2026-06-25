import 'package:flutter/material.dart';
import 'package:tuoc/service/size_service.dart';

class CustomTextTheme {
  static TextStyle titleBarText(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(55),
          color: Colors.white,
        );
  }

  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(55),
          color: Color(0xff3D5058),
        );
  }

  static TextStyle subTitle(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(40),
          color: Color(0xff3D5058),
        );
  }

  static TextStyle buttonText(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline4
        .copyWith(fontSize: 16, color: Colors.white);
  }

  static TextStyle hintTextField(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(35),
          color: Color(0xff999999),
//      color: Color(0xff2E363C),
        );
  }

  static TextStyle linkText(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(40),
          color: Colors.white,
          decoration: TextDecoration.underline,
        );
  }

  static TextStyle content(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(40),
          color: Color(0xff3C95B5),
        );
  }

  static TextStyle regularText(BuildContext context) {
    return Theme.of(context).textTheme.headline4.copyWith(
          fontSize: SizeService.getFontSize(35),
          color: Color(0xff2E363C),
        );
  }
}
