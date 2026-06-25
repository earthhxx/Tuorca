import 'package:json_annotation/json_annotation.dart';

part 'academic_create.g.dart';

@JsonSerializable()
class AcademicCreateModel {
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

  AcademicCreateModel({
    this.schedule_start_date = '',
    this.schedule_start_time = '',
    this.schedule_end_date = '',
    this.schedule_end_time = '',
    this.academic_type_code = '',
    this.title = '',
    this.presenter_1 = '',
    this.presenter_2 = '',
    this.advisor_code = '',
    this.remark = '',
  });

  factory AcademicCreateModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AcademicCreateModelToJson(this);
}
