// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_calendar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicCalendarModel _$AcademicCalendarModelFromJson(
    Map<String, dynamic> json) {
  return AcademicCalendarModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicCalendarDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AcademicCalendarModelToJson(
        AcademicCalendarModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

AcademicCalendarDataModel _$AcademicCalendarDataModelFromJson(
    Map<String, dynamic> json) {
  return AcademicCalendarDataModel(
    json['academic_id'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
  );
}

Map<String, dynamic> _$AcademicCalendarDataModelToJson(
        AcademicCalendarDataModel instance) =>
    <String, dynamic>{
      'academic_id': instance.academic_id,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
    };
