import 'package:flutter/material.dart';
import 'package:tuoc/model/academic/create/academic_create.dart';
import 'package:tuoc/model/academic/edit/academic_edit.dart';
import 'package:tuoc/util/alert.dart';

class AcademicValidate {
  bool onValidate(BuildContext context, AcademicCreateModel data) {
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

  bool onEditValidate(BuildContext context, AcademicEditModel data) {
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
