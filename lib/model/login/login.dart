import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginModel extends BaseModel {
  final LoginDataModel data;

  LoginModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class LoginDataModel {
  final String access_token;

  LoginDataModel(this.access_token);

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
}
