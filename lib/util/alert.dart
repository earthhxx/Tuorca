import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuoc/widget/my_alert.dart';

enum AlertType {
  warning,
  confirm,
}

class Alert {
  final AlertType type;
  final BuildContext context;
  final Widget icon;
  final String title;
  final String message;
  final Function onOk;
  final Function onCancel;
  final String okText;
  final String cancelText;

  Alert(
    this.context, {
    this.icon,
    this.type = AlertType.warning,
    this.title = "Warning",
    @required this.message,
    this.onOk,
    this.onCancel,
    this.okText,
    this.cancelText,
  }) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => MyAlert(
              type: type,
              icon: icon,
              title: title,
              message: message,
              onOK: onOk,
              onCancel: onCancel,
              okText: okText,
              cancelText: cancelText,
            ));
  }
}
