// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicDetailModel _$AcademicDetailModelFromJson(Map<String, dynamic> json) {
  return AcademicDetailModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicDetailDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AcademicDetailModelToJson(
        AcademicDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

AcademicDetailDataModel _$AcademicDetailDataModelFromJson(
    Map<String, dynamic> json) {
  return AcademicDetailDataModel(
    json['academic_id'] as String,
    json['id'] as String,
    json['account_id'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_date'] as String,
    json['schedule_end_time'] as String,
    json['schedule_end_datetime'] as String,
    json['academic_type_code'] as String,
    json['title'] as String,
    json['presenter_1'] as String,
    json['presenter_2'] as String,
    json['advisor_code'] as String,
    json['remark'] as String,
    json['create_at'] as String,
    json['update_at'] as String,
    json['status_code'] as String,
    json['academic_type_name'] as String,
    json['advisor_name'] as String,
  );
}

Map<String, dynamic> _$AcademicDetailDataModelToJson(
        AcademicDetailDataModel instance) =>
    <String, dynamic>{
      'academic_id': instance.academic_id,
      'id': instance.id,
      'account_id': instance.account_id,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'schedule_end_datetime': instance.schedule_end_datetime,
      'academic_type_code': instance.academic_type_code,
      'title': instance.title,
      'presenter_1': instance.presenter_1,
      'presenter_2': instance.presenter_2,
      'advisor_code': instance.advisor_code,
      'remark': instance.remark,
      'create_at': instance.create_at,
      'update_at': instance.update_at,
      'status_code': instance.status_code,
      'academic_type_name': instance.academic_type_name,
      'advisor_name': instance.advisor_name,
    };
