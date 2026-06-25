import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'academic_calendar.g.dart';

@JsonSerializable()
class AcademicCalendarModel extends BaseModel {
  final List<AcademicCalendarDataModel> data;

  AcademicCalendarModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory AcademicCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicCalendarModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicCalendarModelToJson(this);
}

@JsonSerializable()
class AcademicCalendarDataModel {
  final String academic_id;
  final String schedule_start_date;
  final String schedule_start_time;

  AcademicCalendarDataModel(
      this.academic_id, this.schedule_start_date, this.schedule_start_time);

  factory AcademicCalendarDataModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicCalendarDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicCalendarDataModelToJson(this);
}
