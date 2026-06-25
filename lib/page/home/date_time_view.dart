import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl/intl.dart';
import 'package:tuoc/page/edit_profile/edit_profile_page.dart';
import 'package:tuoc/page/my_schedule/my_list/my_list_page.dart';
import 'package:tuoc/service/size_service.dart';
import 'package:tuoc/widget/calendar_icon.dart';

class DateTimeView extends StatefulWidget {
  @override
  _DateTimeViewState createState() => _DateTimeViewState();
}

class _DateTimeViewState extends State<DateTimeView> {
  DateTime _dateTime = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MMMM yyyy');
  final DateFormat _timeFormat = DateFormat('HH.mm');

  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = new Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dateTimeWidget(),
            ),
            Expanded(
              child: _calendarMenu(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateTimeWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SizeService.getPadding(Device.get().isTablet ? 0 : 60)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_dateTime.day}',
            style: TextStyle(
              fontSize: SizeService.getFontSize(180),
              color: Color(0xffC40030),
              height: 1,
            ),
            textAlign: TextAlign.center,
          ),
//          SizedBox(height: SizeService.getHeight(40)),
          Column(
            children: <Widget>[
              Text(
                '${_dateFormat.format(_dateTime)}',
                style: TextStyle(
                  fontSize: SizeService.getFontSize(45),
                  color: Color(0xff3D5058),
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Time : ${_timeFormat.format(_dateTime)}',
                style: TextStyle(
                  fontSize: SizeService.getFontSize(45),
                  color: Color(0xff3D5058),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _calendarMenu() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeService.getPadding(60)),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.push(
                context, CupertinoPageRoute(builder: (_) => MyListPage())),
            child: Column(
              children: <Widget>[
                CalendarIcon(size: 120),
                Text(
                  'My Schedule',
                  style: TextStyle(
                    fontSize: SizeService.getFontSize(45),
                    color: Color(0xff3C95B5),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (_) => EditProfilePage()));
            },
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Color(0xff3D5058))),
            padding: EdgeInsets.symmetric(
                vertical: SizeService.getPadding(16),
                horizontal: SizeService.getPadding(52)),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Color(0xff3D5058),
                fontSize: SizeService.getFontSize(35),
              ),
            ),
          )
        ],
      ),
    );
  }
}
