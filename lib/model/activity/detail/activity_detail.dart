import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'activity_detail.g.dart';

@JsonSerializable()
class ActivityDetailModel extends BaseModel {
  final List<ActivityDetailDataModel> data;

  ActivityDetailModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ActivityDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityDetailModelToJson(this);
}

@JsonSerializable()
class ActivityDetailDataModel {
  final String activity_id;
  final String id;
  final String account_id;
  final String activities_type_code;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_start_datetime;
  final String schedule_end_date;
  final String schedule_end_time;
  final String schedule_end_datetime;
  final String title;
  final String venue;
  final String presenter_1;
  final String presenter_2;
  final String remark;
  final String create_at;
  final String update_at;
  final String status_code;
  final String activity_type_code_name;

  ActivityDetailDataModel(
    this.activity_id,
    this.id,
    this.account_id,
    this.activities_type_code,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_start_datetime,
    this.schedule_end_date,
    this.schedule_end_time,
    this.schedule_end_datetime,
    this.title,
    this.venue,
    this.presenter_1,
    this.presenter_2,
    this.remark,
    this.create_at,
    this.update_at,
    this.status_code,
    this.activity_type_code_name,
  );

  factory ActivityDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityDetailDataModelToJson(this);
}
