// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityListModel _$ActivityListModelFromJson(Map<String, dynamic> json) {
  return ActivityListModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityListModelToJson(ActivityListModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ActivityListDataModel _$ActivityListDataModelFromJson(
    Map<String, dynamic> json) {
  return ActivityListDataModel(
    json['activity_id'] as String,
    json['activity_type_code_name'] as String,
    json['title'] as String,
    json['presenter_1'] as String,
    json['venue'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_datetime'] as String,
  );
}

Map<String, dynamic> _$ActivityListDataModelToJson(
        ActivityListDataModel instance) =>
    <String, dynamic>{
      'activity_id': instance.activity_id,
      'activity_type_code_name': instance.activity_type_code_name,
      'title': instance.title,
      'presenter_1': instance.presenter_1,
      'venue': instance.venue,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_datetime': instance.schedule_end_datetime,
    };
