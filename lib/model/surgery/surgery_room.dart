import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'surgery_room.g.dart';

@JsonSerializable()
class SurgeryRoomModel extends BaseModel {
  final List<SurgeryRoomDataModel> data;

  SurgeryRoomModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory SurgeryRoomModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurgeryRoomModelToJson(this);
}

@JsonSerializable()
class SurgeryRoomDataModel {
  @JsonKey(name: 'room_id')
  final String roomId;
  @JsonKey(name: 'room_name')
  final String roomName;

  SurgeryRoomDataModel(this.roomId, this.roomName);

  factory SurgeryRoomDataModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryRoomDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurgeryRoomDataModelToJson(this);
}
