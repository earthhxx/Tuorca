import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'service_calendar.g.dart';

@JsonSerializable()
class ServiceCalendarModel extends BaseModel {
  final List<ServiceCalendarDataModel> data;

  ServiceCalendarModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ServiceCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCalendarModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCalendarModelToJson(this);
}

@JsonSerializable()
class ServiceCalendarDataModel {
  final String service_id;
  final String schedule_start_date;
  final String schedule_start_time;

  ServiceCalendarDataModel(
      this.service_id, this.schedule_start_date, this.schedule_start_time);

  factory ServiceCalendarDataModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCalendarDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCalendarDataModelToJson(this);
}
