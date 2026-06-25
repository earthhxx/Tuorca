import 'package:json_annotation/json_annotation.dart';

import '../../base_model.dart';

part 'academic_detail.g.dart';

@JsonSerializable()
class AcademicDetailModel extends BaseModel {
  final List<AcademicDetailDataModel> data;

  AcademicDetailModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory AcademicDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicDetailModelToJson(this);
}

@JsonSerializable()
class AcademicDetailDataModel {
  final String academic_id;
  final String id;
  final String account_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_start_datetime;
  final String schedule_end_date;
  final String schedule_end_time;
  final String schedule_end_datetime;
  final String academic_type_code;
  final String title;
  final String presenter_1;
  final String presenter_2;
  final String advisor_code;
  final String remark;
  final String create_at;
  final String update_at;
  final String status_code;
  final String academic_type_name;
  final String advisor_name;

  AcademicDetailDataModel(
    this.academic_id,
    this.id,
    this.account_id,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_start_datetime,
    this.schedule_end_date,
    this.schedule_end_time,
    this.schedule_end_datetime,
    this.academic_type_code,
    this.title,
    this.presenter_1,
    this.presenter_2,
    this.advisor_code,
    this.remark,
    this.create_at,
    this.update_at,
    this.status_code,
    this.academic_type_name,
    this.advisor_name,
  );

  factory AcademicDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicDetailDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicDetailDataModelToJson(this);
}
