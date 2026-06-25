import 'package:json_annotation/json_annotation.dart';

part 'service_edit.g.dart';

@JsonSerializable()
class ServiceEditModel {
  final String service_id;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_end_date;
  final String schedule_end_time;
  final String service_type_code;
  final String groups_code;
  final String or_code;
  final String staff_code;
  final String resident;
  final String intern;
  final String chief_r;
  final String orthopaedic_subspecialties_code;
  final String r_4;
  final String r_3;
  final String r_2;
  final String r_1;
  final String er_daytime;

  ServiceEditModel({
    this.service_id = '',
    this.schedule_start_date = '',
    this.schedule_start_time = '',
    this.schedule_end_date = '',
    this.schedule_end_time = '',
    this.service_type_code = '',
    this.groups_code = '',
    this.or_code = '',
    this.staff_code = '',
    this.resident = '',
    this.intern = '',
    this.chief_r = '',
    this.orthopaedic_subspecialties_code = '',
    this.r_4 = '',
    this.r_3 = '',
    this.r_2 = '',
    this.r_1 = '',
    this.er_daytime = '',
  });

  factory ServiceEditModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceEditModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceEditModelToJson(this);
}
