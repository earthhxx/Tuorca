import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'activity_calendar.g.dart';

@JsonSerializable()
class ActivityCalendarModel extends BaseModel {
  final List<ActivityCalendarDataModel> data;

  ActivityCalendarModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ActivityCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityCalendarModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityCalendarModelToJson(this);
}

@JsonSerializable()
class ActivityCalendarDataModel {
  final String activity_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_end_date;
  final String schedule_end_time;
  final List<String> date_period;

  ActivityCalendarDataModel(
    this.activity_id,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_end_date,
    this.schedule_end_time,
    this.date_period,
  );

  factory ActivityCalendarDataModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityCalendarDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityCalendarDataModelToJson(this);
}
