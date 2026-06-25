import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/service/calendar/service_calendar.dart';
import 'package:tuoc/model/service/list/service_list.dart';
import 'package:tuoc/page/service_schedule/service_detail/service_detail_page.dart';
import 'package:tuoc/page/service_schedule/service_select_type/service_select_type_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/string_format_util.dart';

import 'service_list_page.dart';

class ServiceListPresenter extends BasePresenter<ServiceListPage> {
  Api _api;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  DateTime selectedDate = DateTime.now();
  CalendarController calendarController = CalendarController();
  var events = HashMap<DateTime, List<String>>();
  List<ServiceListDataModel> listEvent = [];

  DateTime _startDate;
  DateTime _endDate;

  ServiceListPresenter(State<ServiceListPage> state) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getServiceCalendar();
    await _getServiceList();
    Loading(state.context).hide();
    loaded();
  }

  Future onRefresh() async {
    loading();
    await _getServiceList();
    loaded();
  }

  _getServiceCalendar() async {
    if (_startDate == null && _endDate == null) {
      var now = DateTime.now();
      var year = now.year;
      var month = now.month == 12 ? now.month : now.month + 1;
      _startDate = new DateTime(year, now.month, 1);
      _endDate = new DateTime(year, month, 0);
    }

    _api = Api<ServiceCalendarModel>();

    var res = await _api.getServiceCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      ServiceCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (ServiceCalendarDataModel data) => data.schedule_start_date)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.service_id).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }
  }

  _getServiceList() async {
    _api = Api<ServiceListModel>();

    var res = await _api.getServiceList({
      "start_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "action_type": "list",
    });

    if (res.fail == null) {
      ServiceListModel model = res.success;
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

  onSelectDate(DateTime date) async {
    await loading();

    setState(() {
      selectedDate = date;
    });

    await _getServiceList();

    await loaded();
  }

  onChangedMonth(DateTime first, DateTime last) async {
    loading();
    if (first.day == 1)
      _startDate = first;
    else {
      _startDate = DateTime(first.year, first.month + 1, 1);
    }
    _endDate = last;

    _api = Api<ServiceCalendarModel>();

    var res = await _api.getServiceCalendar({
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      ServiceCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (ServiceCalendarDataModel data) => data.schedule_start_date)
            .forEach((k, v) {
          events.addAll({
            DateTime.parse(k): v.map((item) => item.service_id).toList(),
          });
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }

    await _getServiceList();
    loaded();
  }

  createSchedule() async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => ServiceSelectTypePage(
          initialDate: selectedDate,
        ),
      ),
    );

    await _getServiceCalendar();
    refreshKey.currentState.show();
  }

  gotoDetail(String serviceId, String serviceTypeName) async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => ServiceDetailPage(
            serviceId: serviceId, serviceTypeName: serviceTypeName),
      ),
    );

    await _getServiceCalendar();
    refreshKey.currentState.show();
  }
}
