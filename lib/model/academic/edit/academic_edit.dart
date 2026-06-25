import 'package:json_annotation/json_annotation.dart';

part 'academic_edit.g.dart';

@JsonSerializable()
class AcademicEditModel {
  final String academic_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_end_date;
  final String schedule_end_time;
  final String academic_type_code;
  final String title;
  final String presenter_1;
  final String presenter_2;
  final String advisor_code;
  final String remark;

  AcademicEditModel({
    this.academic_id,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_end_date,
    this.schedule_end_time,
    this.academic_type_code,
    this.title,
    this.presenter_1,
    this.presenter_2,
    this.advisor_code,
    this.remark,
  });

  factory AcademicEditModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicEditModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicEditModelToJson(this);
}
