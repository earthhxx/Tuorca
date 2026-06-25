import 'package:json_annotation/json_annotation.dart';

part 'surgery_edit.g.dart';

@JsonSerializable()
class SurgeryEditModel {
  final String surgery_id;
  final String room_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_end_date;
  final String schedule_end_time;
  final String staff_code;
  final String patient_name;
  final String age_code;
  final String phone_number;
  final String hn;
  final String operative_room_code;
  final String group_code;
  final String ordes_code;
  final String anesth_code;
  final String dx;
  final String op;
  final String implant;
  final String vip_code;
  final String opd_ipd;
  final String remark;

  SurgeryEditModel({
    this.surgery_id,
    this.room_id,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_end_date,
    this.schedule_end_time,
    this.staff_code,
    this.patient_name,
    this.age_code,
    this.phone_number,
    this.hn,
    this.operative_room_code,
    this.group_code,
    this.ordes_code,
    this.anesth_code,
    this.dx,
    this.op,
    this.implant,
    this.vip_code,
    this.opd_ipd,
    this.remark,
  });

  factory SurgeryEditModel.fromJson(Map<String, dynamic> json) =>
      _$SurgeryEditModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurgeryEditModelToJson(this);
}
