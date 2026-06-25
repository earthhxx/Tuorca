import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'surgery_detail.g.dart';

@JsonSerializable()
class SurgeryDetailModel extends BaseModel {
  final List<SurgeryDetailDataModel> data;

  SurgeryDetailModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory SurgeryDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryDetailModelToJson(this);
}

@JsonSerializable()
class SurgeryDetailDataModel {
  final String surgery_id;
  final String id;
  final String account_id;
  final String room_id;
  final String room_name;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_start_datetime;
  final String schedule_end_date;
  final String schedule_end_time;
  final String schedule_end_datetime;
  final String staff_code;
  final String patient_name;
  final String age;
  final String phone_number;
  final String hn;
  final String operative_room_code;
  final String group_code;
  final String ordes_code;
  final String duration;
  final String duration_name;
  final String anesth_code;
  final String vip_code;
  final String opd_ipd;
  final String remark;
  final String status_code;
  final String create_at;
  final String update_at;
  final String staff_name;
  final String operative_room_data;
  final String group_name;
  final String group_color;
  final String ordes_name;
  final String anesth_name;
  final String vip_name;
  final List<String> dx;
  final List<String> op;
  final List<String> implant;

  SurgeryDetailDataModel({
    this.surgery_id,
    this.id,
    this.account_id,
    this.room_id,
    this.room_name,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_start_datetime,
    this.schedule_end_date,
    this.schedule_end_time,
    this.schedule_end_datetime,
    this.staff_code,
    this.patient_name,
    this.age,
    this.phone_number,
    this.hn,
    this.operative_room_code,
    this.group_code,
    this.ordes_code,
    this.duration,
    this.anesth_code,
    this.vip_code,
    this.opd_ipd,
    this.remark,
    this.status_code,
    this.create_at,
    this.update_at,
    this.staff_name,
    this.operative_room_data,
    this.group_name,
    this.group_color,
    this.ordes_name,
    this.anesth_name,
    this.vip_name,
    this.dx,
    this.op,
    this.implant,
    this.duration_name,
  });

  factory SurgeryDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryDetailDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurgeryDetailDataModelToJson(this);
}
