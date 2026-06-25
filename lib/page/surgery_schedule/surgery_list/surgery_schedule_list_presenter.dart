import 'dart:collection';

import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/surgery/surgery_calendar.dart';
import 'package:tuoc/model/surgery/surgery_list.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/page/surgery_schedule/surgery_create/surgery_create_page.dart';
import 'package:tuoc/page/surgery_schedule/surgery_detail/surgery_detail_page.dart';
import 'package:tuoc/service/api.dart';
import 'package:tuoc/util/loading.dart';
import 'package:tuoc/util/string_format_util.dart';

import 'surgery_schedule_list_page.dart';

class SurgerySchedulePresenter extends BasePresenter<SurgeryScheduleListPage> {
  Api _api;
  List<SurgeryRoomDataModel> listData = [];

  final refreshKey = GlobalKey<RefreshIndicatorState>();
// Callback

// Default value
//   DateTime selectedDate = DateTime.now();

  // DateTime selectedDate = DateTime.now();
  CalendarController calendarController = CalendarController();
  var events = HashMap<DateTime, List<String>>();
  List<SurgeryListDataModel> listEvent = [];
  DateTime selectedDate = DateTime.now();

  DateTime _startDate;
  DateTime _endDate;

  SurgerySchedulePresenter(
    State<SurgeryScheduleListPage> state,
  ) : super(state) {
    Future.delayed(Duration.zero, () => _initPage());
  }

  _initPage() async {
    loading();
    Loading(state.context).show();
    await _getRoom();
    await _getSurgeryCalendar();
    await _getSurgeryList();
    Loading(state.context).hide();
    loaded();
  }

  Future onRefresh() async {
    loading();
    await _getSurgeryList();
    loaded();
  }

  // Future onRefresh() async {
  //   loading();
  //
  //   await _getRoom();
  //
  //   loaded();
  // }

  _getRoom() async {
    _api = Api<SurgeryRoomModel>();

    var res = await _api.getSurgeryRoom({});

    if (res.fail == null) {
      SurgeryRoomModel model = res.success;
      if (model.statusCode == 200) {
        listData = model.data;
      } else {
        _getRoomFail();
      }
    } else {
      _getRoomFail();
    }
  }

  _getRoomFail() {
    listData = [];
  }

  _getSurgeryCalendar() async {
    if (_startDate == null && _endDate == null) {
      var now = DateTime.now();
      var year = now.year;
      var month = now.month == 12 ? now.month : now.month + 1;
      _startDate = new DateTime(year, now.month, 1);
      _endDate = new DateTime(year, month, 0);
    }

    _api = Api<SurgeryCalendarModel>();

    var res = await _api.getSurgeryCalendar({
      "room_id": state.widget.roomId,
      "start_date": "${StringFormatUtil().getDateForParse(_startDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(_endDate)}",
      "action_type": "calendar",
    });

    if (res.fail == null) {
      SurgeryCalendarModel model = res.success;
      if (model.statusCode == 200) {
        events = HashMap<DateTime, List<String>>();
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

  _getSurgeryList() async {
    _api = Api<SurgeryListModel>();

    var res = await _api.getSurgeryList({
      "room_id": state.widget.roomId,
      "start_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "end_date": "${StringFormatUtil().getDateForParse(selectedDate)}",
      "action_type": "list",
    });

    if (res.fail == null) {
      // print(res.success);

      SurgeryListModel model = res.success;
      // print(model.data[2].vip_name);
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

    await _getSurgeryList();

    await loaded();
  }

// Called when the visible month changes
  Future<void> onChangedMonth(DateTime first, DateTime last) async {
    loading();
    _startDate =
        (first.day == 1) ? first : DateTime(first.year, first.month + 1, 1);
    _endDate = last;

    _api = Api<SurgeryCalendarModel>();

    final res = await _api.getSurgeryCalendar({
      "room_id": state.widget.roomId,
      "start_date": StringFormatUtil().getDateForParse(_startDate),
      "end_date": StringFormatUtil().getDateForParse(_endDate),
      "action_type": "calendar",
    });

    if (res.fail == null) {
      final model = res.success as SurgeryCalendarModel;
      if (model.statusCode == 200) {
        events.clear();
        groupBy(model.data,
                (SurgeryCalendarDataModel data) => data.scheduleStartDate)
            .forEach((k, v) {
          events[DateTime.parse(k)] = v.map((item) => item.surgeryId).toList();
        });
      } else {
        events.clear();
      }
    } else {
      events.clear();
    }

    loaded();
  }

  createSchedule() async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => SurgeryCreatePage(
          initialDate: selectedDate,
          roomId: state.widget.roomId,
          roomName: state.widget.roomName,
        ),
      ),
    );

    await _getSurgeryCalendar();
    refreshKey.currentState.show();
  }

  Future<void> gotoDetail(String id) async {
    await Navigator.push(
      state.context,
      CupertinoPageRoute(
        builder: (_) => SurgeryDetailPage(
            roomId: state.widget.roomId,
            roomName: state.widget.roomName,
            surgeryId: id),
      ),
    );

    await _getSurgeryCalendar();
    refreshKey.currentState.show();
  }
}
