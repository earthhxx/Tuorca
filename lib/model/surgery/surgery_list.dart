import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'surgery_list.g.dart';

@JsonSerializable()
class SurgeryListModel extends BaseModel {
  final List<SurgeryListDataModel> data;

  SurgeryListModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory SurgeryListModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryListModelToJson(this);
}

@JsonSerializable()
class SurgeryListDataModel {
  @JsonKey(name: 'surgery_id')
  final String surgeryId;
  @JsonKey(name: 'room_id')
  final String roomId;
  @JsonKey(name: 'staff_name')
  final String staffName;
  @JsonKey(name: 'schedule_start_datetime')
  final String scheduleStartDatetime;
  @JsonKey(name: 'schedule_end_datetime')
  final String scheduleEndDatetime;

  @JsonKey(name: 'room_name')
  final String roomName;
  @JsonKey(name: 'group_color')
  final String groupColor;

  @JsonKey(name: 'patient_name')
  final String patientName;
  @JsonKey(name: 'vip_code')
  final String vip_code;

  @JsonKey(name: 'vip_name')
  final String vip_name;

  final List<String> dx;
  final List<String> op;
  final List<String> implant;

  SurgeryListDataModel(
      this.surgeryId,
      this.roomId,
      this.staffName,
      this.dx,
      this.op,
      this.implant,
      this.scheduleStartDatetime,
      this.scheduleEndDatetime,
      this.roomName,
      this.groupColor,
      this.patientName,
      this.vip_code,
      this.vip_name);

  factory SurgeryListDataModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryListDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryListDataModelToJson(this);
}
