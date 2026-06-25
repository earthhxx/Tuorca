// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryListModel _$SurgeryListModelFromJson(Map<String, dynamic> json) {
  return SurgeryListModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SurgeryListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurgeryListModelToJson(SurgeryListModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

SurgeryListDataModel _$SurgeryListDataModelFromJson(Map<String, dynamic> json) {
  return SurgeryListDataModel(
    json['surgery_id'] as String,
    json['room_id'] as String,
    json['staff_name'] as String,
    (json['dx'] as List)?.map((e) => e as String)?.toList(),
    (json['op'] as List)?.map((e) => e as String)?.toList(),
    (json['implant'] as List)?.map((e) => e as String)?.toList(),
    json['schedule_start_datetime'] as String,
    json['schedule_end_datetime'] as String,
    json['room_name'] as String,
    json['group_color'] as String,
    json['patient_name'] as String,
    json['vip_code'] as String,
    json['vip_name'] as String,
  );
}

Map<String, dynamic> _$SurgeryListDataModelToJson(
        SurgeryListDataModel instance) =>
    <String, dynamic>{
      'surgery_id': instance.surgeryId,
      'room_id': instance.roomId,
      'staff_name': instance.staffName,
      'schedule_start_datetime': instance.scheduleStartDatetime,
      'schedule_end_datetime': instance.scheduleEndDatetime,
      'room_name': instance.roomName,
      'group_color': instance.groupColor,
      'patient_name': instance.patientName,
      'vip_code': instance.vip_code,
      'vip_name': instance.vip_name,
      'dx': instance.dx,
      'op': instance.op,
      'implant': instance.implant,
    };
