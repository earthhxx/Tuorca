// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityCreateModel _$ActivityCreateModelFromJson(Map<String, dynamic> json) {
  return ActivityCreateModel(
    schedule_start_date: json['schedule_start_date'] as String,
    schedule_start_time: json['schedule_start_time'] as String,
    schedule_end_date: json['schedule_end_date'] as String,
    schedule_end_time: json['schedule_end_time'] as String,
    activities_type_code: json['activities_type_code'] as String,
    title: json['title'] as String,
    presenter_1: json['presenter_1'] as String,
    presenter_2: json['presenter_2'] as String,
    remark: json['remark'] as String,
    venue: json['venue'] as String,
  );
}

Map<String, dynamic> _$ActivityCreateModelToJson(
        ActivityCreateModel instance) =>
    <String, dynamic>{
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'activities_type_code': instance.activities_type_code,
      'title': instance.title,
      'presenter_1': instance.presenter_1,
      'presenter_2': instance.presenter_2,
      'remark': instance.remark,
      'venue': instance.venue,
    };
