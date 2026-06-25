import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/academic/calendar/academic_calendar.dart';
import 'package:tuoc/model/academic/list/academic_list.dart';
import 'package:tuoc/page/academic_schedule/academic_create/academic_create_page.dart';
import 'package:tuoc/page/academic_schedule/academic_detail/academic_detail_page.dart';
import 'package:tuoc/page/academic_schedule/academic_list/academic_list_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/string_format_util.dart';

class AcademicListPresenter extends BasePresenter<AcademicListPage> {
  Api _api;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  DateTime selectedDate = DateTime.now();
  CalendarController calendarController = CalendarController();
  var events = HashMap<DateTime, List<String>>();
  List<AcademicListDataModel> listEvent = [];

  DateTime _startDate;
  DateTime _endDate;

  AcademicListPresenter(State<AcademicListPage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getAcademicCalendar();
    await _getAcademicList();
    Loading(state.context).hide();
    loaded();
  }

  Future onRefresh() async {
    loading();
    await _getAcademicList();
    loaded();
  }

  onSelectDate(DateTime date) async {
    await loading();

    setState(() {
      selectedDate = date;
    });

    await _getAcademicList();

    await loaded();
  }

  _getAcademicCalendar() async {
    if (_startDate == null && _endDate == null) {
      var now = DateTime.now();
      var year = now.year;
      var month = now.month == 12 ? now.month : now.month + 1;
      _startDate = new DateTime(year, now.month, 1);
      _endDate = new DateTime(year, month, 0);
    }

    _api = Api<AcademicCalendarModel>();

    var res = await _api.getAcademicCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      AcademicCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events = HashMap<DateTime, List<String>>();
        groupBy(model.data,
                (AcademicCalendarDataModel data) => data.schedule_start_date)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.academic_id).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }
  }

  _getAcademicList() async {
//    _getAcademicListFail();
    _api = Api<AcademicListModel>();

    var res = await _api.getAcademicList({
      "start_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "action_type": "list",
    });

    if (res.fail == null) {
      AcademicListModel model = res.success;
      if (model.statusCode == 200) {
        listEvent = model.data;
      } else {
        _getAcademicListFail();
      }
    } else {
      _getAcademicListFail();
    }
  }

  _getAcademicListFail() {
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

    _api = Api<AcademicCalendarModel>();

    var res = await _api.getAcademicCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      AcademicCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (AcademicCalendarDataModel data) => data.schedule_start_date)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.academic_id).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }

    await _getAcademicList();
    loaded();
  }

  gotoCreate() async {
    await Navigator.push(
        state.context,
        CupertinoPageRoute(
            builder: (_) => AcademicCreatePage(initialDate: selectedDate)));

    await _getAcademicCalendar();
    refreshKey.currentState.show();
  }

  gotoDetail(String academicId) async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => AcademicDetailPage(academicId: academicId),
      ),
    );

    await _getAcademicCalendar();
    refreshKey.currentState.show();
  }
}
