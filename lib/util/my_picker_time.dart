import 'package:flutter/cupertino.dart';
import 'package:tuoc/util/string_format_util.dart';
import 'package:tuoc/widget/time_picker_view.dart';

class MyPickerTime {
  BuildContext context;
  DateTime initialTime;
  String minTime;
  String maxTime;

  MyPickerTime({
    this.context,
    this.initialTime,
    this.minTime,
    this.maxTime,
  });

  Future<String> getTime() async {
    var now = DateTime.now();
    var min = this.minTime != null
        ? DateTime.parse(
            '${StringFormatUtil().getDateForParse(now)} ${this.minTime}')
        : null;
    var max = this.maxTime != null
        ? DateTime.parse(
            '${StringFormatUtil().getDateForParse(now)} ${this.maxTime}')
        : null;
    return await showCupertinoModalPopup(
      context: this.context,
      builder: (context) => TimePickerView(
        initialTime: this.initialTime,
        minTime: min,
        maxTime: max,
      ),
    );
  }
}
