// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityDetailModel _$ActivityDetailModelFromJson(Map<String, dynamic> json) {
  return ActivityDetailModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityDetailDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityDetailModelToJson(
        ActivityDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ActivityDetailDataModel _$ActivityDetailDataModelFromJson(
    Map<String, dynamic> json) {
  return ActivityDetailDataModel(
    json['activity_id'] as String,
    json['id'] as String,
    json['account_id'] as String,
    json['activities_type_code'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_date'] as String,
    json['schedule_end_time'] as String,
    json['schedule_end_datetime'] as String,
    json['title'] as String,
    json['venue'] as String,
    json['presenter_1'] as String,
    json['presenter_2'] as String,
    json['remark'] as String,
    json['create_at'] as String,
    json['update_at'] as String,
    json['status_code'] as String,
    json['activity_type_code_name'] as String,
  );
}

Map<String, dynamic> _$ActivityDetailDataModelToJson(
        ActivityDetailDataModel instance) =>
    <String, dynamic>{
      'activity_id': instance.activity_id,
      'id': instance.id,
      'account_id': instance.account_id,
      'activities_type_code': instance.activities_type_code,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'schedule_end_datetime': instance.schedule_end_datetime,
      'title': instance.title,
      'venue': instance.venue,
      'presenter_1': instance.presenter_1,
      'presenter_2': instance.presenter_2,
      'remark': instance.remark,
      'create_at': instance.create_at,
      'update_at': instance.update_at,
      'status_code': instance.status_code,
      'activity_type_code_name': instance.activity_type_code_name,
    };
