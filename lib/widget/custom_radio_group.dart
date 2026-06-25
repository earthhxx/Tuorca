import 'package:flutter/material.dart';
import 'package:tuoc/environment/custom_text_theme.dart';
import 'package:tuoc/service/size_service.dart';

class CustomRadioGroup extends StatefulWidget {
  final double buttonSize;
  final Function onChanged;
  final int initialValue;

  CustomRadioGroup(
      {Key key, this.buttonSize = 24, this.onChanged, this.initialValue})
      : super(key: key);

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  int value = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      // if (widget.initialValue == true) {
      //   value = 1;
      // } else {
      //   value = 0;
      // }
      value = widget.initialValue ?? 0;
    });
    print("value ${value}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _radioItem('OPD', widget.initialValue == true ? 1 : 0),
          _radioItem('IPD', widget.initialValue == true ? 0 : 1),
        ],
      ),
    );
  }

  Widget _radioItem(String name, int value) {
    return InkWell(
      onTap: () {
        setState(() {
          this.value = value;
          print(value);
        });

        if (widget.onChanged != null) widget.onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Container(
            width: widget.buttonSize,
            height: widget.buttonSize,
            decoration: BoxDecoration(
                color: this.value == value
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xffCCCCCC), width: 2)),
          ),
          SizedBox(width: SizeService.getPadding(22)),
          Text(
            '$name',
            style: CustomTextTheme.hintTextField(context),
          )
        ],
      ),
    );
  }
}
