import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';

class HomeMenuItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color color;
  final Widget page;

  HomeMenuItem({this.imagePath, this.title, this.color, @required this.page});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
        horizontal: SizeService.getPadding(88),
        vertical: SizeService.getPadding(Device.get().isTablet ? 44 : 86),
      ),
      onPressed: () {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => this.page));
      },
      color: Colors.white,
      splashColor: Color(0xff9FDFF8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: ImageIcon(
                AssetImage(this.imagePath ?? ''),
                color: this.color,
                size: SizeService.getFontSize(170),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${this.title ?? ''}',
                  style: CustomTextTheme.title(context).copyWith(
                    height: 1,
                  ),
                ),
                Text(
                  'Schedule',
                  style: CustomTextTheme.subTitle(context).copyWith(
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeService.getWidth(30),
            height: SizeService.getWidth(15),
            decoration: BoxDecoration(
                color: this.color, borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}
