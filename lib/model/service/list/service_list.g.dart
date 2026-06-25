// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceListModel _$ServiceListModelFromJson(Map<String, dynamic> json) {
  return ServiceListModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceListModelToJson(ServiceListModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ServiceListDataModel _$ServiceListDataModelFromJson(Map<String, dynamic> json) {
  return ServiceListDataModel(
    json['service_id'] as String,
    json['service_type_name'] as String,
    json['chief_r'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_datetime'] as String,
  );
}

Map<String, dynamic> _$ServiceListDataModelToJson(
        ServiceListDataModel instance) =>
    <String, dynamic>{
      'service_id': instance.service_id,
      'service_type_name': instance.service_type_name,
      'chief_r': instance.chief_r,
      'schedule_start_datetime': instance.scheduleStartDatetime,
      'schedule_end_datetime': instance.scheduleEndDatetime,
    };
