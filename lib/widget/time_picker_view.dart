import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/util/string_format_util.dart';

// ignore: must_be_immutable
class TimePickerView extends StatefulWidget {
  final DateTime initialTime;
  final DateTime minTime;
  final DateTime maxTime;

  TimePickerView({this.initialTime, this.minTime, this.maxTime});

  @override
  _TimePickerViewState createState() => _TimePickerViewState();
}

class _TimePickerViewState extends State<TimePickerView> {
  String _hour;
  String _minute;

  FixedExtentScrollController _hsc = FixedExtentScrollController();
  FixedExtentScrollController _msc = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeService.getPadding(44)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: SizeService.getPadding(56),
                right: SizeService.getPadding(56),
                left: SizeService.getPadding(56),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _titleTime(),
                  _picker(),
                  SizedBox(height: SizeService.getPadding(58)),
                ],
              ),
            ),
          ),
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: _actionButton(context),
          ),
        ],
      ),
    );
  }

  Widget _titleTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Start',
          style: TextStyle(
            color: Color(0xff999999),
            fontSize: SizeService.getFontSize(40),
            height: 1,
          ),
        ),
        Text(
          '${StringFormatUtil().getTimeFormat(this.widget.initialTime)}',
          style: TextStyle(
            color: Color(0xff2E363C),
            fontSize: SizeService.getFontSize(100),
            height: 1,
          ),
        )
      ],
    );
  }

  Widget _picker() {
    var numFormat = NumberFormat('00');
    int minH = widget.minTime.hour;
    int maxH = widget.maxTime.hour;
    int minM = widget.minTime.minute;
    int maxM = widget.maxTime.minute;
    bool hasMinHaft = widget.minTime.minute > 0;
    bool hasMaxHaft = widget.maxTime.minute > 0;
    _minute = _minute != null ? _minute : numFormat.format(minM);
    List<Widget> hourItems = [];
    List<Widget> minItems = [];
    final List<int> minData = [0, 15, 30, 45];
    List<int> minuteIndex = [0, 15, 30, 45];

    if (_hour == null && widget.initialTime != null) {
      var time =
          StringFormatUtil().getTimeFormat(this.widget.initialTime).split(':');

      _hour = time[0];
      _minute = time[1];

      var indexStart = int.parse(_hour) - minH;

      _hsc = FixedExtentScrollController(initialItem: indexStart);
      _msc = FixedExtentScrollController(
          initialItem: minuteIndex.indexOf(widget.initialTime.minute));
    } else if (_hour == null) {
      _hour = _hour != null ? _hour : numFormat.format(minH);
    }

    for (var i = minH; i <= maxH; i++) {
      hourItems.add(
        Container(
          alignment: Alignment.center,
          child: Text(
            '${numFormat.format(i)}',
            style: TextStyle(
              fontSize: SizeService.getFontSize(150),
              color: Color(0xff2E363C),
            ),
          ),
        ),
      );
    }

    if (int.parse(_hour) < maxH || hasMaxHaft) {
      if (int.parse(_hour) == minH && hasMinHaft)
        minuteIndex = minData.where((w) => w >= minM).toList();
      else if (minuteIndex.length < 2) minuteIndex = minData;
    } else {
      if (minuteIndex.length > 1)
        minuteIndex = minData.where((w) => w <= maxM).toList();
    }

    minItems = minuteIndex.map((index) {
      var i = index;

      return Container(
        alignment: Alignment.center,
        child: Text(
          '${numFormat.format(i)}',
          style: TextStyle(
            fontSize: SizeService.getFontSize(150),
            color: Color(0xff2E363C),
          ),
        ),
      );
    }).toList();

    if (minItems.length < minData.length && _msc.hasClients) {
      _msc.jumpTo(0);
    }

    return Container(
      height: SizeService.getHeight(360),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: CupertinoPicker(
                    scrollController: _hsc,
                    itemExtent: SizeService.getHeight(360),
                    backgroundColor: Color(0xff3C95B5).withOpacity(0.2),
                    onSelectedItemChanged: (v) {
                      setState(() {
                        _hour = numFormat.format(v + minH);
                      });
                    },
                    children: hourItems,
                  ),
                ),
                Expanded(
                  child: minItems.length > 1
                      ? CupertinoPicker(
                          scrollController: _msc,
                          itemExtent: SizeService.getHeight(360),
                          backgroundColor: Color(0xff3C95B5).withOpacity(0.2),
                          onSelectedItemChanged: (v) {
                            _minute = numFormat.format(v * 15);
                          },
                          children: minItems,
                        )
                      : CupertinoPicker(
                          scrollController: _msc,
                          itemExtent: SizeService.getHeight(360),
                          backgroundColor: Color(0xff3C95B5).withOpacity(0.2),
                          onSelectedItemChanged: (v) {
                            _minute = numFormat.format(v * 15);
                          },
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '00',
                                style: TextStyle(
                                  fontSize: SizeService.getFontSize(149),
                                  color: Color(0xff2E363C),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ],
            ),
            Container(
              color: Color(0xff2E363C),
              width: SizeService.getPadding(8),
              height: SizeService.getPadding(64),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      child: Row(
        children: <Widget>[
          _cancelButton(context),
          _okButton(context),
        ],
      ),
    );
  }

  Widget _okButton(BuildContext context) {
    return Expanded(
      child: Container(
//        padding: EdgeInsets.symmetric(
//            horizontal: SizeService.getPadding(16),
//            vertical: SizeService.getPadding(16)),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xffCCCCCC), width: 1),
          ),
        ),
        child: MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
          onPressed: () {
            Navigator.pop(context, '$_hour:$_minute');
          },
          color: Colors.white,
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.red,
              fontSize: SizeService.getFontSize(45),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Expanded(
      child: Container(
//        padding: EdgeInsets.symmetric(
//            horizontal: SizeService.getPadding(16),
//            vertical: SizeService.getPadding(16)),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xffCCCCCC), width: 1),
            right: BorderSide(color: Color(0xffCCCCCC), width: 1),
          ),
        ),
        child: MaterialButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
          ),
          padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(44)),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: SizeService.getFontSize(45),
            ),
          ),
        ),
      ),
    );
  }
}
