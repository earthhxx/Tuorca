import 'package:flutter/material.dart';
import 'package:tuoc/environment/base_presenter.dart';
import 'package:tuoc/model/surgery/surgery_room.dart';
import 'package:tuoc/service/api.dart';

import 'surgery_schedule_room.dart';

class SurgeryScheduleRoomPresenter extends BasePresenter<SurgeryScheduleRoom> {
  Api _api;

  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  List<SurgeryRoomDataModel> listData = [];

  SurgeryScheduleRoomPresenter(State<SurgeryScheduleRoom> state)
      : super(state) {
    Future.delayed(Duration.zero, () => refreshKey.currentState.show());
  }

  Future onRefresh() async {
    loading();

    await _getRoom();

    loaded();
  }

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
}
