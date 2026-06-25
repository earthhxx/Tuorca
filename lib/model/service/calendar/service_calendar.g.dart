// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCalendarModel _$ServiceCalendarModelFromJson(Map<String, dynamic> json) {
  return ServiceCalendarModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceCalendarDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceCalendarModelToJson(
        ServiceCalendarModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ServiceCalendarDataModel _$ServiceCalendarDataModelFromJson(
    Map<String, dynamic> json) {
  return ServiceCalendarDataModel(
    json['service_id'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
  );
}

Map<String, dynamic> _$ServiceCalendarDataModelToJson(
        ServiceCalendarDataModel instance) =>
    <String, dynamic>{
      'service_id': instance.service_id,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
    };
