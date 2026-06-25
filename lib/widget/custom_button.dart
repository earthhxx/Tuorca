import 'package:flutter/material.dart';
import 'package:tuoc/service/size_service.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color color;
  final double elevation;
  final double radius;

  CustomButton({
    this.onPressed,
    this.buttonText,
    this.color,
    this.elevation,
    this.radius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: this.onPressed ?? () {},
        color: this.color ?? Color.fromRGBO(194, 0, 40, 1),
        elevation: this.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.radius),
        ),
        padding: EdgeInsets.only(
          top: SizeService.getPadding(34),
          bottom: SizeService.getPadding(38),
        ),
        child: Text(
          '${this.buttonText ?? ''}',
          style: TextStyle(
            fontSize: SizeService.getFontSize(52),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
