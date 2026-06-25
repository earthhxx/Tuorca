import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'service_list.g.dart';

@JsonSerializable()
class ServiceListModel extends BaseModel {
  final List<ServiceListDataModel> data;

  ServiceListModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceListModelToJson(this);
}

@JsonSerializable()
class ServiceListDataModel {
  final String service_id;
  final String service_type_name;
  final String chief_r;
  @JsonKey(name: 'schedule_start_datetime')
  final String scheduleStartDatetime;
  @JsonKey(name: 'schedule_end_datetime')
  final String scheduleEndDatetime;

  ServiceListDataModel(this.service_id, this.service_type_name, this.chief_r,
      this.scheduleStartDatetime, this.scheduleEndDatetime);

  factory ServiceListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceListDataModelToJson(this);
}
