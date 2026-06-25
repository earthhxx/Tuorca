import 'package:flutter/material.dart';
import 'package:tuoc/model/activity/create/activity_create.dart';
import 'package:tuoc/model/activity/edit/activity_edit.dart';
import 'package:tuoc/util/alert.dart';

class ActivityValidate {
  bool onValidate(BuildContext context, ActivityCreateModel data) {
    try {
      if (data.schedule_start_time.isEmpty ||
          data.schedule_start_time == '--:--') {
        throw ('Please select start time');
      }
      if (data.schedule_end_time.isEmpty || data.schedule_end_time == '--:--') {
        throw ('Please select end time');
      }
      return true;
    } catch (e) {
      Alert(
        context,
        message: '$e',
      );
      return false;
    }
  }

  bool onEditValidate(BuildContext context, ActivityEditModel data) {
    try {
      if (data.schedule_start_time.isEmpty ||
          data.schedule_start_time == '--:--') {
        throw ('Please select start time');
      }
      if (data.schedule_end_time.isEmpty || data.schedule_end_time == '--:--') {
        throw ('Please select end time');
      }
      return true;
    } catch (e) {
      Alert(
        context,
        message: '$e',
      );
      return false;
    }
  }
}
