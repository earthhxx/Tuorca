// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryRoomModel _$SurgeryRoomModelFromJson(Map<String, dynamic> json) {
  return SurgeryRoomModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SurgeryRoomDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurgeryRoomModelToJson(SurgeryRoomModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

SurgeryRoomDataModel _$SurgeryRoomDataModelFromJson(Map<String, dynamic> json) {
  return SurgeryRoomDataModel(
    json['room_id'] as String,
    json['room_name'] as String,
  );
}

Map<String, dynamic> _$SurgeryRoomDataModelToJson(
        SurgeryRoomDataModel instance) =>
    <String, dynamic>{
      'room_id': instance.roomId,
      'room_name': instance.roomName,
    };
