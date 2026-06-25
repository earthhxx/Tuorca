import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/alert.dart';

class MyAlert extends StatelessWidget {
  final AlertType type;
  final Widget icon;
  final String title;
  final String message;
  final Function onOK;
  final Function onCancel;
  final String okText;
  final String cancelText;

  MyAlert({
    @required this.title,
    this.message,
    this.type = AlertType.warning,
    this.onOK,
    this.onCancel,
    this.okText = 'ตกลง',
    this.cancelText = 'ยกเลิก',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.4),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(66)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon ?? _title(context),
                    _message(context),
                    _actionButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeService.getPadding(30),
        horizontal: SizeService.getPadding(10),
      ),
      child: Text(
        '${this.title}',
        style: CustomTextTheme.content(context).copyWith(
          fontSize: SizeService.getFontSize(65),
          color: this.title.toLowerCase() == 'warning'
              ? Colors.red
              : Color(0xff3C95B5),
        ),
      ),
    );
  }

  Widget _message(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeService.getPadding(16),
        ),
        child: SingleChildScrollView(
          child: Text(
            '${this.message}',
            style: CustomTextTheme.content(context)
                .copyWith(fontSize: SizeService.getFontSize(45)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          this.type != AlertType.warning ? _cancelButton(context) : Container(),
          _okButton(context),
        ],
      ),
    );
  }

  Widget _okButton(BuildContext context) {
    return Expanded(
      child: Container(
//        padding: EdgeInsets.symmetric(
//            horizontal: SizeService.getPadding(16),
//            vertical: SizeService.getPadding(16)),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xffCCCCCC), width: 1))),
        child: MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
          onPressed: () {
            Navigator.pop(context);
            if (onOK != null) {
              onOK();
            }
          },
          color: Colors.white,
          child: Text(
            this.okText ?? 'OK',
            style: TextStyle(
              color: this.type == AlertType.confirm
                  ? Colors.red
                  : Theme.of(context).primaryColor,
              fontSize: SizeService.getFontSize(45),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Expanded(
      child: Container(
//        padding: EdgeInsets.symmetric(
//            horizontal: SizeService.getPadding(16),
//            vertical: SizeService.getPadding(16)),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xffCCCCCC), width: 1),
            right: BorderSide(color: Color(0xffCCCCCC), width: 1),
          ),
        ),
        child: MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
          onPressed: () {
            Navigator.pop(context);
            if (onCancel != null) {
              onCancel();
            }
          },
          color: Colors.white,
          child: Text(
            this.cancelText ?? 'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: SizeService.getFontSize(45),
            ),
          ),
        ),
      ),
    );
  }
}
