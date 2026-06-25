import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'my_profile.g.dart';

@JsonSerializable()
class MyProfileModel extends BaseModel {
  final List<MyProfileDataModel> data;
  MyProfileModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory MyProfileModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyProfileModelToJson(this);
}

@JsonSerializable()
class MyProfileDataModel {
  final String account_id;
  final String fname;
  final String lname;
  final String email;
  final String work_position;
  final String phone;
  final String fax;
  final String username;
  final String account_type;
  final String last_login_at;
  final String image_profile;

  MyProfileDataModel(
    this.account_id,
    this.fname,
    this.lname,
    this.email,
    this.work_position,
    this.phone,
    this.fax,
    this.username,
    this.account_type,
    this.last_login_at,
    this.image_profile,
  );

  factory MyProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyProfileDataModelToJson(this);
}
