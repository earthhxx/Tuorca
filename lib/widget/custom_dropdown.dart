import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final dynamic initialValue;
  final List<DropdownMenuItem> items;
  final Function validator;
  final Color borderColor;
  final double borderSize;
  final Color fillColor;
  final double fontSize;

  CustomDropdown({
    Key key,
    this.hintText,
    this.onChanged,
    this.initialValue,
    this.items,
    this.validator,
    this.borderColor,
    this.borderSize,
    this.fillColor,
    this.fontSize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(items.length);
    return DropdownButtonFormField(
      isExpanded: true,
      style: CustomTextTheme.hintTextField(context).copyWith(
          fontSize: SizeService.getFontSize(this.fontSize),
          color: Color(0xff2E363C)),
      hint: Text(
        '${this.hintText}',
        style: CustomTextTheme.hintTextField(context),
      ),
      elevation: 0,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeService.getPadding(40),
          vertical: SizeService.getPadding(Device.get().isTablet ? 36 : 0),
        ),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        filled: true,
        fillColor: this.fillColor ?? Colors.white,
      ),
      icon: _dropdownIcon(),
      value: this.initialValue,
      items: this.items,
      validator: this.validator,
      onChanged: (v) {
        if (this.onChanged != null) this.onChanged(v);
      },
    );
  }

  Widget _dropdownIcon() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color(0xffCCCCCC),
      ),
      width: SizeService.getWidth(50),
      height: SizeService.getHeight(10),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: this.borderColor ?? Colors.white,
        width: this.borderSize ?? 1.5,
      ),
    );
  }
}
