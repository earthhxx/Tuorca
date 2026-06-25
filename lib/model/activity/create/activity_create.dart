import 'package:json_annotation/json_annotation.dart';

part 'activity_create.g.dart';

@JsonSerializable()
class ActivityCreateModel {
  final String schedule_start_date;
  String schedule_start_time;
  final String schedule_end_date;
  String schedule_end_time;
  final String activities_type_code;
  final String title;
  final String presenter_1;
  final String presenter_2;
  final String remark;
  final String venue;

  ActivityCreateModel({
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

  factory ActivityCreateModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityCreateModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityCreateModelToJson(this);
}
