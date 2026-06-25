import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final int statusCode;
  final String message;

  BaseModel(this.statusCode, this.message);

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}

@JsonSerializable()
class FailModel {
  final int statusCode;
  final String message;

  FailModel(this.statusCode, this.message);

  factory FailModel.fromJson(Map<String, dynamic> json) =>
      _$FailModelFromJson(json);
  Map<String, dynamic> toJson() => _$FailModelToJson(this);
}
