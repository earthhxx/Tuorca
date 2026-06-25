import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'master_data.g.dart';

@JsonSerializable()
class MasterDataModel extends BaseModel {
  final MasterDataListModel data;

  MasterDataModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory MasterDataModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$MasterDataModelToJson(this);
}

@JsonSerializable()
class MasterDataListModel {
  final List<StaffListDataModel> staff_data;
  final TimeDataModel time_data;
  final List<OperativeRoomListDataModel> operative_room_data;
  final List<GroupListDataModel> group_data;
  final List<OrderListDataModel> order_data;
  final List<AnesthListDataModel> anesth_data;
  final List<AcademicTypeListDataModel> academic_type_data;
  final List<VIPListDataModel> vip_data;
  final List<AdvisorListDataModel> advisor_data;
  final List<ServiceTypeListData> service_type_data;
  final List<OrderListDataModel> or_data;
  final List<OrthopaedicSubspecialtiesListDataModel>
      orthopaedic_subspecialties_data;
  final List<ActivitiesTypeListDataModel> activities_type_data;
  final AgeDataModel age_data;
  final Map is_fake;

  MasterDataListModel(
      this.staff_data,
      this.time_data,
      this.operative_room_data,
      this.group_data,
      this.order_data,
      this.anesth_data,
      this.academic_type_data,
      this.vip_data,
      this.advisor_data,
      this.service_type_data,
      this.or_data,
      this.orthopaedic_subspecialties_data,
      this.activities_type_data,
      this.age_data,
      this.is_fake);

  factory MasterDataListModel.fromJson(Map<String, dynamic> json) =>
      _$MasterDataListModelFromJson(json);
  Map<String, dynamic> toJson() => _$MasterDataListModelToJson(this);
}

@JsonSerializable()
class AcademicTypeListDataModel {
  final String code;
  final String name;

  AcademicTypeListDataModel(this.code, this.name);

  factory AcademicTypeListDataModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicTypeListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicTypeListDataModelToJson(this);
}

@JsonSerializable()
class ActivitiesTypeListDataModel {
  final String code;
  final String name;

  ActivitiesTypeListDataModel(this.code, this.name);

  factory ActivitiesTypeListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesTypeListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivitiesTypeListDataModelToJson(this);
}

@JsonSerializable()
class AdvisorListDataModel {
  final String code;
  final String name;

  AdvisorListDataModel(this.code, this.name);

  factory AdvisorListDataModel.fromJson(Map<String, dynamic> json) =>
      _$AdvisorListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdvisorListDataModelToJson(this);
}

@JsonSerializable()
class AnesthListDataModel {
  final String code;
  final String name;

  AnesthListDataModel(this.code, this.name);

  factory AnesthListDataModel.fromJson(Map<String, dynamic> json) =>
      _$AnesthListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnesthListDataModelToJson(this);
}

@JsonSerializable()
class GroupListDataModel {
  final String code;
  final String name;
  final String color;

  GroupListDataModel(this.code, this.name, this.color);

  factory GroupListDataModel.fromJson(Map<String, dynamic> json) =>
      _$GroupListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$GroupListDataModelToJson(this);
}

@JsonSerializable()
class OperativeRoomListDataModel {
  final String code;
  final String name;

  OperativeRoomListDataModel(this.code, this.name);

  factory OperativeRoomListDataModel.fromJson(Map<String, dynamic> json) =>
      _$OperativeRoomListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$OperativeRoomListDataModelToJson(this);
}

@JsonSerializable()
class OrListDataModel {
  final String code;
  final String name;

  OrListDataModel(this.code, this.name);

  factory OrListDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrListDataModelToJson(this);
}

@JsonSerializable()
class OrderListDataModel {
  final String code;
  final String name;

  OrderListDataModel(this.code, this.name);

  factory OrderListDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListDataModelToJson(this);
}

@JsonSerializable()
class OrthopaedicSubspecialtiesListDataModel {
  final String code;
  final String name;

  OrthopaedicSubspecialtiesListDataModel(this.code, this.name);

  factory OrthopaedicSubspecialtiesListDataModel.fromJson(
          Map<String, dynamic> json) =>
      _$OrthopaedicSubspecialtiesListDataModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$OrthopaedicSubspecialtiesListDataModelToJson(this);
}

@JsonSerializable()
class TimeDataModel {
  final String min;
  final String max;

  TimeDataModel(this.min, this.max);

  factory TimeDataModel.fromJson(Map<String, dynamic> json) =>
      _$TimeDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimeDataModelToJson(this);
}

@JsonSerializable()
class ServiceTypeListData {
  final String code;
  final String name;

  ServiceTypeListData(this.code, this.name);

  factory ServiceTypeListData.fromJson(Map<String, dynamic> json) =>
      _$ServiceTypeListDataFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceTypeListDataToJson(this);
}

@JsonSerializable()
class StaffListDataModel {
  final String code;
  final String name;

  StaffListDataModel(this.code, this.name);

  factory StaffListDataModel.fromJson(Map<String, dynamic> json) =>
      _$StaffListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$StaffListDataModelToJson(this);
}

@JsonSerializable()
class VIPListDataModel {
  final String code;
  final String name;

  VIPListDataModel(this.code, this.name);

  factory VIPListDataModel.fromJson(Map<String, dynamic> json) =>
      _$VIPListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$VIPListDataModelToJson(this);
}

@JsonSerializable()
class AgeDataModel {
  final int min;
  final int max;

  AgeDataModel(this.min, this.max);

  factory AgeDataModel.fromJson(Map<String, dynamic> json) =>
      _$AgeDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgeDataModelToJson(this);
}
