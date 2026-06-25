import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final Widget suffixIcon;
  final Color borderColor;
  final double borderSize;
  final int minLine;
  final int maxLine;
  final bool obscureText;
  final Function validator;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  final bool enabled;

  CustomTextField({
    this.hintText,
    this.fontSize = 35,
    this.suffixIcon,
    this.obscureText = false,
    this.borderColor,
    this.borderSize,
    this.minLine,
    this.maxLine = 1,
    this.controller,
    this.enabled = true,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      enabled: this.enabled,
      style: CustomTextTheme.hintTextField(context).copyWith(
          fontSize: SizeService.getFontSize(this.fontSize),
          color: Color(0xff2E363C)),
      decoration: InputDecoration(
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        fillColor: Colors.white.withOpacity(.5),
        filled: true,
        hintText: this.hintText,
        hintStyle: CustomTextTheme.hintTextField(context)
            .copyWith(fontSize: SizeService.getFontSize(this.fontSize)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeService.getPadding(40),
          vertical: SizeService.getPadding(36),
        ),
        suffixIcon: this.suffixIcon,
      ),
      onChanged: (txt) {
        // print(txt);
      },
      minLines: this.minLine,
      maxLines: this.maxLine,
      obscureText: obscureText,
      validator: this.validator,
      inputFormatters: this.inputFormatters,
      keyboardType: keyboardType,
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
            color: this.borderColor ?? Colors.white,
            width: this.borderSize ?? 1.5));
  }
}
