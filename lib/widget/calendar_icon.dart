import 'package:flutter/material.dart';
import 'package:tuoc/service/size_service.dart';

class CalendarIcon extends StatelessWidget {
  final double size;

  CalendarIcon({this.size = 32});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage('assets/icons/ic_calendar.png'),
      color: Color(0xff3C95B5),
      size: SizeService.getFontSize(this.size),
    );
  }
}
