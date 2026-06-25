import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/activity/calendar/activity_calendar.dart';
import 'package:tuoc/model/activity/list/activity_list.dart';
import 'package:tuoc/page/activity_schedule/activity_create/activity_create_page.dart';
import 'package:tuoc/page/activity_schedule/activity_detail/activity_detail_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/string_format_util.dart';

class ActivityListPresenter extends BasePresenter {
  Api _api;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  DateTime selectedDate = DateTime.now();
  CalendarController calendarController = CalendarController();
  var events = HashMap<DateTime, List<String>>();
  List<ActivityListDataModel> listEvent = [];

  DateTime _startDate;
  DateTime _endDate;

  ActivityListPresenter(State<StatefulWidget> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  onSelectDate(DateTime date) async {
    await loading();

    setState(() {
      selectedDate = date;
    });

    await _getList();

    await loaded();
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getCalendar();
    await _getList();
    Loading(state.context).hide();
    loaded();
  }

  Future onRefresh() async {
    loading();
    await _getList();
    loaded();
  }

  _getCalendar() async {
    if (_startDate == null && _endDate == null) {
      var now = DateTime.now();
      var year = now.year;
      var month = now.month == 12 ? now.month : now.month + 1;
      _startDate = new DateTime(year, now.month, 1);
      _endDate = new DateTime(year, month, 0);
    }

    _api = Api<ActivityCalendarModel>();

    var res = await _api.getActivityCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      ActivityCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        events = _mapEvent(model.data);
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }
  }

  _mapEvent(List<ActivityCalendarDataModel> data) {
    var d = HashMap<DateTime, List<String>>();
    if (data.length > 0) {
      data.forEach((item) {
        if (item.date_period.length > 0) {
          item.date_period.forEach((date) {
            if (d.containsKey(DateTime.parse('$date 00:00:00'))) {
              d[DateTime.parse('$date 00:00:00')].add(date);
            } else {
              d.addAll({
                DateTime.parse('$date 00:00:00'): [date],
              });
            }
          });
        }
      });
    }

    return d;
  }

  _getList() async {
    _api = Api<ActivityListModel>();

    var res = await _api.getActivityList({
      "start_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "action_type": "list",
    });

    if (res.fail == null) {
      ActivityListModel model = res.success;
      if (model.statusCode == 200) {
        listEvent = model.data;
      } else {
        listEvent = [];
      }
    } else {
      listEvent = [];
    }
  }

  onChangedMonth(DateTime first, DateTime last) async {
    loading();
    if (first.day == 1)
      _startDate = first;
    else {
      _startDate = DateTime(first.year, first.month + 1, 1);
    }
    _endDate = last;

    _api = Api<ActivityCalendarModel>();

    var res = await _api.getActivityCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      ActivityCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        events = _mapEvent(model.data);
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }

    await _getList();
    loaded();
  }

  gotoCreate() async {
    await Navigator.push(
        state.context,
        CupertinoPageRoute(
            builder: (_) => ActivityCreatePage(initialDate: selectedDate)));

    await _getCalendar();
    refreshKey.currentState.show();
  }

  gotoDetail(String activityId) async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => ActivityDetailPage(
          activityId: activityId,
        ),
      ),
    );

    await _getCalendar();
    refreshKey.currentState.show();
  }
}
