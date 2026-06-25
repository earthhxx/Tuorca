// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return BaseModel(
    json['statusCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };

FailModel _$FailModelFromJson(Map<String, dynamic> json) {
  return FailModel(
    json['statusCode'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$FailModelToJson(FailModel instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
