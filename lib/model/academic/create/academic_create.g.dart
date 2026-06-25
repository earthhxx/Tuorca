// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicCreateModel _$AcademicCreateModelFromJson(Map<String, dynamic> json) {
  return AcademicCreateModel(
    schedule_start_date: json['schedule_start_date'] as String,
    schedule_start_time: json['schedule_start_time'] as String,
    schedule_end_date: json['schedule_end_date'] as String,
    schedule_end_time: json['schedule_end_time'] as String,
    academic_type_code: json['academic_type_code'] as String,
    title: json['title'] as String,
    presenter_1: json['presenter_1'] as String,
    presenter_2: json['presenter_2'] as String,
    advisor_code: json['advisor_code'] as String,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$AcademicCreateModelToJson(
        AcademicCreateModel instance) =>
    <String, dynamic>{
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'academic_type_code': instance.academic_type_code,
      'title': instance.title,
      'presenter_1': instance.presenter_1,
      'presenter_2': instance.presenter_2,
      'advisor_code': instance.advisor_code,
      'remark': instance.remark,
    };
