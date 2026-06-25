// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCalendarModel _$ActivityCalendarModelFromJson(
    Map<String, dynamic> json) {
  return ActivityCalendarModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityCalendarDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityCalendarModelToJson(
        ActivityCalendarModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ActivityCalendarDataModel _$ActivityCalendarDataModelFromJson(
    Map<String, dynamic> json) {
  return ActivityCalendarDataModel(
    json['activity_id'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
    json['schedule_end_date'] as String,
    json['schedule_end_time'] as String,
    (json['date_period'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ActivityCalendarDataModelToJson(
        ActivityCalendarDataModel instance) =>
    <String, dynamic>{
      'activity_id': instance.activity_id,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'date_period': instance.date_period,
    };
