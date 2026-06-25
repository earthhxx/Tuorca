import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'surgery_calendar.g.dart';

@JsonSerializable()
class SurgeryCalendarModel extends BaseModel {
  final List<SurgeryCalendarDataModel> data;

  SurgeryCalendarModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory SurgeryCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryCalendarModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurgeryCalendarModelToJson(this);
}

@JsonSerializable()
class SurgeryCalendarDataModel {
  @JsonKey(name: 'surgery_id')
  final String surgeryId;
  @JsonKey(name: 'schedule_start_date')
  final String scheduleStartDate;
  @JsonKey(name: 'schedule_start_time')
  final String scheduleStartTime;

  SurgeryCalendarDataModel(
      this.surgeryId, this.scheduleStartDate, this.scheduleStartTime);

  factory SurgeryCalendarDataModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryCalendarDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurgeryCalendarDataModelToJson(this);
}
