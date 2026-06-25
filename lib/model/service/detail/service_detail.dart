import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'service_detail.g.dart';

@JsonSerializable()
class ServiceDetailModel extends BaseModel {
  final List<ServiceDetailDataModel> data;

  ServiceDetailModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceDetailModelToJson(this);
}

@JsonSerializable()
class ServiceDetailDataModel {
  final String service_id;
  final String id;
  final String account_id;
  final String service_type_code;
  final String schedule_start_date;
  final String schedule_start_time;
  final String schedule_start_datetime;
  final String schedule_end_date;
  final String schedule_end_time;
  final String schedule_end_datetime;
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
  final String create_at;
  final String update_at;
  final String status_code;
  final String service_type_name;
  final String groups_name;
  final String groups_color;
  final String or_name;
  final String staff_name;
  final String orthopaedic_subspecialties_name;

  ServiceDetailDataModel(
    this.service_id,
    this.id,
    this.account_id,
    this.service_type_code,
    this.schedule_start_date,
    this.schedule_start_time,
    this.schedule_start_datetime,
    this.schedule_end_date,
    this.schedule_end_time,
    this.schedule_end_datetime,
    this.groups_code,
    this.or_code,
    this.staff_code,
    this.resident,
    this.intern,
    this.chief_r,
    this.orthopaedic_subspecialties_code,
    this.r_4,
    this.r_3,
    this.r_2,
    this.r_1,
    this.er_daytime,
    this.create_at,
    this.update_at,
    this.status_code,
    this.service_type_name,
    this.groups_name,
    this.groups_color,
    this.or_name,
    this.staff_name,
    this.orthopaedic_subspecialties_name,
  );

  factory ServiceDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceDetailDataModelToJson(this);
}
