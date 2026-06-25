import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/surgery/surgery_calendar.dart';
import 'package:tuoc/model/surgery/surgery_list.dart';
import 'package:tuoc/page/my_schedule/my_detail/my_detail_page.dart';
import 'package:tuoc/page/my_schedule/my_list/my_list_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/string_format_util.dart';

class MyListPresenter extends BasePresenter<MyListPage> {
  Api _api;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  DateTime selectedDate = DateTime.now();
  CalendarController calendarController = CalendarController();
  var events = HashMap<DateTime, List<String>>();
  List<SurgeryListDataModel> listEvent = [];

  DateTime _startDate;
  DateTime _endDate;

  MyListPresenter(State<MyListPage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  onSelectDate(DateTime date) {
    setState(() {
      selectedDate = date ?? DateTime.now();
    });
    onSelectDate?.call(selectedDate);
    refreshKey.currentState?.show();
  }

  Future onRefresh() async {
    loading();
    await _getList();
    loaded();
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getCalendar();
    await _getList();
    Loading(state.context).hide();
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

    _api = Api<SurgeryCalendarModel>();

    var res = await _api.getMyScheduleCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      SurgeryCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (SurgeryCalendarDataModel data) => data.scheduleStartDate)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.surgeryId).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }
  }

  _getList() async {
    _api = Api<SurgeryListModel>();

    var res = await _api.getMyScheduleList({
      "start_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "action_type": "list",
    });

    if (res.fail == null) {
      SurgeryListModel model = res.success;
      if (model.statusCode == 200) {
        listEvent = model.data;
      } else {
        _getSurgeryListFail();
      }
    } else {
      _getSurgeryListFail();
    }
  }

  _getSurgeryListFail() {
    listEvent = [];
  }

  onChangedMonth(DateTime first, DateTime last) async {
    loading();
    if (first.day == 1)
      _startDate = first;
    else {
      _startDate = DateTime(first.year, first.month + 1, 1);
    }
    _endDate = last;

    _api = Api<SurgeryCalendarModel>();

    var res = await _api.getMyScheduleCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      SurgeryCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (SurgeryCalendarDataModel data) => data.scheduleStartDate)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.surgeryId).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }

    await _getList();
    loaded();
  }

  Future<void> gotoDetail(String surgeryId, String roomId) async {
    await Navigator.push(
        state.context,
        CupertinoPageRoute(
            builder: (_) =>
                MyDetailPage(surgeryId: surgeryId, roomId: roomId)));

    await _getCalendar();
    refreshKey.currentState.show();
  }
}
