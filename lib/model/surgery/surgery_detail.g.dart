// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryDetailModel _$SurgeryDetailModelFromJson(Map<String, dynamic> json) {
  return SurgeryDetailModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SurgeryDetailDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurgeryDetailModelToJson(SurgeryDetailModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

SurgeryDetailDataModel _$SurgeryDetailDataModelFromJson(
    Map<String, dynamic> json) {
  return SurgeryDetailDataModel(
    surgery_id: json['surgery_id'] as String,
    id: json['id'] as String,
    account_id: json['account_id'] as String,
    room_id: json['room_id'] as String,
    room_name: json['room_name'] as String,
    schedule_start_date: json['schedule_start_date'] as String,
    schedule_start_time: json['schedule_start_time'] as String,
    schedule_start_datetime: json['schedule_start_datetime'] as String,
    schedule_end_date: json['schedule_end_date'] as String,
    schedule_end_time: json['schedule_end_time'] as String,
    schedule_end_datetime: json['schedule_end_datetime'] as String,
    staff_code: json['staff_code'] as String,
    patient_name: json['patient_name'] as String,
    age: json['age'] as String,
    phone_number: json['phone_number'] as String,
    hn: json['hn'] as String,
    operative_room_code: json['operative_room_code'] as String,
    group_code: json['group_code'] as String,
    ordes_code: json['ordes_code'] as String,
    duration: json['duration'] as String,
    anesth_code: json['anesth_code'] as String,
    vip_code: json['vip_code'] as String,
    opd_ipd: json['opd_ipd'] as String,
    remark: json['remark'] as String,
    status_code: json['status_code'] as String,
    create_at: json['create_at'] as String,
    update_at: json['update_at'] as String,
    staff_name: json['staff_name'] as String,
    operative_room_data: json['operative_room_data'] as String,
    group_name: json['group_name'] as String,
    group_color: json['group_color'] as String,
    ordes_name: json['ordes_name'] as String,
    anesth_name: json['anesth_name'] as String,
    vip_name: json['vip_name'] as String,
    dx: (json['dx'] as List)?.map((e) => e as String)?.toList(),
    op: (json['op'] as List)?.map((e) => e as String)?.toList(),
    implant: (json['implant'] as List)?.map((e) => e as String)?.toList(),
    duration_name: json['duration_name'] as String,
  );
}

Map<String, dynamic> _$SurgeryDetailDataModelToJson(
        SurgeryDetailDataModel instance) =>
    <String, dynamic>{
      'surgery_id': instance.surgery_id,
      'id': instance.id,
      'account_id': instance.account_id,
      'room_id': instance.room_id,
      'room_name': instance.room_name,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'schedule_end_datetime': instance.schedule_end_datetime,
      'staff_code': instance.staff_code,
      'patient_name': instance.patient_name,
      'age': instance.age,
      'phone_number': instance.phone_number,
      'hn': instance.hn,
      'operative_room_code': instance.operative_room_code,
      'group_code': instance.group_code,
      'ordes_code': instance.ordes_code,
      'duration': instance.duration,
      'duration_name': instance.duration_name,
      'anesth_code': instance.anesth_code,
      'vip_code': instance.vip_code,
      'opd_ipd': instance.opd_ipd,
      'remark': instance.remark,
      'status_code': instance.status_code,
      'create_at': instance.create_at,
      'update_at': instance.update_at,
      'staff_name': instance.staff_name,
      'operative_room_data': instance.operative_room_data,
      'group_name': instance.group_name,
      'group_color': instance.group_color,
      'ordes_name': instance.ordes_name,
      'anesth_name': instance.anesth_name,
      'vip_name': instance.vip_name,
      'dx': instance.dx,
      'op': instance.op,
      'implant': instance.implant,
    };
