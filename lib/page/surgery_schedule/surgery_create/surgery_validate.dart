import 'package:flutter/cupertino.dart';
import 'package:tuoc/model/surgery/surgery_create.dart';
import 'package:tuoc/model/surgery/surgery_edit.dart';
import 'package:tuoc/util/alert.dart';

class SurgeryValidate {
  bool onValidate(BuildContext context, SurgeryCreateModel data) {
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
      print(e);
      Alert(
        context,
        message: '$e',
      );
      return false;
    }
  }

  bool onEditValidate(BuildContext context, SurgeryEditModel data) {
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
      print(e);
      Alert(
        context,
        message: '$e',
      );
      return false;
    }
  }
}
