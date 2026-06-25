// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryEditModel _$SurgeryEditModelFromJson(Map<String, dynamic> json) {
  return SurgeryEditModel(
    surgery_id: json['surgery_id'] as String,
    room_id: json['room_id'] as String,
    schedule_start_date: json['schedule_start_date'] as String,
    schedule_start_time: json['schedule_start_time'] as String,
    schedule_end_date: json['schedule_end_date'] as String,
    schedule_end_time: json['schedule_end_time'] as String,
    staff_code: json['staff_code'] as String,
    patient_name: json['patient_name'] as String,
    age_code: json['age_code'] as String,
    phone_number: json['phone_number'] as String,
    hn: json['hn'] as String,
    operative_room_code: json['operative_room_code'] as String,
    group_code: json['group_code'] as String,
    ordes_code: json['ordes_code'] as String,
    anesth_code: json['anesth_code'] as String,
    dx: json['dx'] as String,
    op: json['op'] as String,
    implant: json['implant'] as String,
    vip_code: json['vip_code'] as String,
    opd_ipd: json['opd_ipd'] as String,
    remark: json['remark'] as String,
  );
}

Map<String, dynamic> _$SurgeryEditModelToJson(SurgeryEditModel instance) =>
    <String, dynamic>{
      'surgery_id': instance.surgery_id,
      'room_id': instance.room_id,
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'staff_code': instance.staff_code,
      'patient_name': instance.patient_name,
      'age_code': instance.age_code,
      'phone_number': instance.phone_number,
      'hn': instance.hn,
      'operative_room_code': instance.operative_room_code,
      'group_code': instance.group_code,
      'ordes_code': instance.ordes_code,
      'anesth_code': instance.anesth_code,
      'dx': instance.dx,
      'op': instance.op,
      'implant': instance.implant,
      'vip_code': instance.vip_code,
      'opd_ipd': instance.opd_ipd,
      'remark': instance.remark,
    };
