// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDetailModel _$ServiceDetailModelFromJson(Map<String, dynamic> json) {
  return ServiceDetailModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceDetailDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceDetailModelToJson(ServiceDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

ServiceDetailDataModel _$ServiceDetailDataModelFromJson(
    Map<String, dynamic> json) {
  return ServiceDetailDataModel(
    json['service_id'] as String,
    json['id'] as String,
    json['account_id'] as String,
    json['service_type_code'] as String,
    json['schedule_start_date'] as String,
    json['schedule_start_time'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_date'] as String,
    json['schedule_end_time'] as String,
    json['schedule_end_datetime'] as String,
    json['groups_code'] as String,
    json['or_code'] as String,
    json['staff_code'] as String,
    json['resident'] as String,
    json['intern'] as String,
    json['chief_r'] as String,
    json['orthopaedic_subspecialties_code'] as String,
    json['r_4'] as String,
    json['r_3'] as String,
    json['r_2'] as String,
    json['r_1'] as String,
    json['er_daytime'] as String,
    json['create_at'] as String,
    json['update_at'] as String,
    json['status_code'] as String,
    json['service_type_name'] as String,
    json['groups_name'] as String,
    json['groups_color'] as String,
    json['or_name'] as String,
    json['staff_name'] as String,
    json['orthopaedic_subspecialties_name'] as String,
  );
}

Map<String, dynamic> _$ServiceDetailDataModelToJson(
        ServiceDetailDataModel instance) =>
    <String, dynamic>{
      'service_id': instance.service_id,
      'id': instance.id,
      'account_id': instance.account_id,
      'service_type_code': instance.service_type_code,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'schedule_end_datetime': instance.schedule_end_datetime,
      'groups_code': instance.groups_code,
      'or_code': instance.or_code,
      'staff_code': instance.staff_code,
      'resident': instance.resident,
      'intern': instance.intern,
      'chief_r': instance.chief_r,
      'orthopaedic_subspecialties_code':
          instance.orthopaedic_subspecialties_code,
      'r_4': instance.r_4,
      'r_3': instance.r_3,
      'r_2': instance.r_2,
      'r_1': instance.r_1,
      'er_daytime': instance.er_daytime,
      'create_at': instance.create_at,
      'update_at': instance.update_at,
      'status_code': instance.status_code,
      'service_type_name': instance.service_type_name,
      'groups_name': instance.groups_name,
      'groups_color': instance.groups_color,
      'or_name': instance.or_name,
      'staff_name': instance.staff_name,
      'orthopaedic_subspecialties_name':
          instance.orthopaedic_subspecialties_name,
    };
