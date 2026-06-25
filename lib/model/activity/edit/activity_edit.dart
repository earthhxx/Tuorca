import 'package:json_annotation/json_annotation.dart';

part 'activity_edit.g.dart';

@JsonSerializable()
class ActivityEditModel {
  final String activity_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_end_date;
  final String schedule_end_time;
  final String activities_type_code;
  final String title;
  final String presenter_1;
  final String presenter_2;
  final String remark;
  final String venue;

  ActivityEditModel({
    this.activity_id,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_end_date,
    this.schedule_end_time,
    this.activities_type_code,
    this.title,
    this.presenter_1,
    this.presenter_2,
    this.remark,
    this.venue,
  });

  factory ActivityEditModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityEditModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityEditModelToJson(this);
}
