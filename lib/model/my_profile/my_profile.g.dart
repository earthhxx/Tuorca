// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileModel _$MyProfileModelFromJson(Map<String, dynamic> json) {
  return MyProfileModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : MyProfileDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyProfileModelToJson(MyProfileModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

MyProfileDataModel _$MyProfileDataModelFromJson(Map<String, dynamic> json) {
  return MyProfileDataModel(
    json['account_id'] as String,
    json['fname'] as String,
    json['lname'] as String,
    json['email'] as String,
    json['work_position'] as String,
    json['phone'] as String,
    json['fax'] as String,
    json['username'] as String,
    json['account_type'] as String,
    json['last_login_at'] as String,
    json['image_profile'] as String,
  );
}

Map<String, dynamic> _$MyProfileDataModelToJson(MyProfileDataModel instance) =>
    <String, dynamic>{
      'account_id': instance.account_id,
      'fname': instance.fname,
      'lname': instance.lname,
      'email': instance.email,
      'work_position': instance.work_position,
      'phone': instance.phone,
      'fax': instance.fax,
      'username': instance.username,
      'account_type': instance.account_type,
      'last_login_at': instance.last_login_at,
      'image_profile': instance.image_profile,
    };
