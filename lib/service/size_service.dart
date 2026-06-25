import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeService {
  BuildContext context;

  SizeService(this.context) {
    ScreenUtil.init(context, width: 1080, height: 1920);
  }

  static double getPadding(double value) {
    return ScreenUtil().setWidth(value);
  }

  static double getWidth(double value) {
    return ScreenUtil().setWidth(value);
  }

  static double getHeight(double value) {
    return ScreenUtil().setHeight(value);
  }

  static double getFontSize(double value) {
    return ScreenUtil().setSp(value, allowFontScalingSelf: true);
  }

  static double getScreenWidth() {
    return ScreenUtil.screenWidth;
  }

  static double getScreenHeight() {
    return ScreenUtil.screenHeight;
  }
}
