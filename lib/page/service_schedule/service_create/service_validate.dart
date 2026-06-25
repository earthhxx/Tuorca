import 'package:flutter/cupertino.dart';
import 'package:tuoc/model/service/create/service_or_create.dart';
import 'package:tuoc/model/service/edit/service_edit.dart';
import 'package:tuoc/util/alert.dart';

class ServiceValidate {
  bool onValidate(BuildContext context, ServiceCreateModel data) {
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

  bool onEditValidate(BuildContext context, ServiceEditModel data) {
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
