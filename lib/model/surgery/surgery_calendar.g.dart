// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryCalendarModel _$SurgeryCalendarModelFromJson(Map<String, dynamic> json) {
  return SurgeryCalendarModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SurgeryCalendarDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurgeryCalendarModelToJson(
        SurgeryCalendarModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

SurgeryCalendarDataModel _$SurgeryCalendarDataModelFromJson(
    Map<String, dynamic> json) {
  return SurgeryCalendarDataModel(
    json['surgery_id'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
  );
}

Map<String, dynamic> _$SurgeryCalendarDataModelToJson(
        SurgeryCalendarDataModel instance) =>
    <String, dynamic>{
      'surgery_id': instance.surgeryId,
      'schedule_start_date': instance.scheduleStartDate,
      'schedule_start_time': instance.scheduleStartTime,
    };
