import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:tuoc/service/size_service.dart';

class YesNoInputField extends StatefulWidget {
  final String title;
  bool initialValue;
  final Function onChanged;
  final double fontSize;

  YesNoInputField(
      {Key key,
      @required this.initialValue,
      @required this.onChanged,
      @required this.title,
      this.fontSize = 35})
      : super(key: key);

  @override
  _YesNoInputFieldState createState() => _YesNoInputFieldState();
}

class _YesNoInputFieldState extends State<YesNoInputField> {
  bool value = true;

  @override
  void initState() {
    super.initState();

    this.value = widget.initialValue ?? true;
    value = widget.initialValue;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeService.getPadding(16)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeService.getPadding(40),
        vertical: SizeService.getPadding(Device.get().isTablet ? 36 : 26),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Color(0xff2E363C),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '${widget.title}',
              style: TextStyle(
                fontSize: SizeService.getFontSize(35),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: CupertinoSegmentedControl(
              padding: EdgeInsets.all(0),
              onValueChanged: (v) {
                setState(() {
                  value = v;
                  widget.initialValue = v;
                  // print(widget.initialValue);
                  // print(v);
                });

                if (widget.onChanged != null) widget.onChanged(v);
              },
              groupValue: widget.initialValue,
              selectedColor: Color(0xff3C95B5),
              children: {
                true: Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: SizeService.getFontSize(35),
                  ),
                ),
                false: Text(
                  'No',
                  style: TextStyle(
                    fontSize: SizeService.getFontSize(35),
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
