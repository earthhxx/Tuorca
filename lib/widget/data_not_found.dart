import 'package:flutter/material.dart';
import 'package:tuoc/service/size_service.dart';

class DataNotFound extends StatelessWidget {
  final Color colorText;
  final double height;

  DataNotFound({this.colorText = Colors.white, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: this.height ?? MediaQuery.of(context).size.height * .3,
      child: Text(
        'Data not found',
        style: TextStyle(
          fontSize: SizeService.getFontSize(55),
          fontWeight: FontWeight.w500,
          color: this.colorText,
        ),
      ),
    );
  }
}
