// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataModel _$MasterDataModelFromJson(Map<String, dynamic> json) {
  return MasterDataModel(
    json['statusCode'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : MasterDataListModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MasterDataModelToJson(MasterDataModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

MasterDataListModel _$MasterDataListModelFromJson(Map<String, dynamic> json) {
  return MasterDataListModel(
    (json['staff_data'] as List)
        ?.map((e) => e == null
            ? null
            : StaffListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['time_data'] == null
        ? null
        : TimeDataModel.fromJson(json['time_data'] as Map<String, dynamic>),
    (json['operative_room_data'] as List)
        ?.map((e) => e == null
            ? null
            : OperativeRoomListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['group_data'] as List)
        ?.map((e) => e == null
            ? null
            : GroupListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['order_data'] as List)
        ?.map((e) => e == null
            ? null
            : OrderListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['anesth_data'] as List)
        ?.map((e) => e == null
            ? null
            : AnesthListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['academic_type_data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicTypeListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['vip_data'] as List)
        ?.map((e) => e == null
            ? null
            : VIPListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['advisor_data'] as List)
        ?.map((e) => e == null
            ? null
            : AdvisorListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['service_type_data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceTypeListData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['or_data'] as List)
        ?.map((e) => e == null
            ? null
            : OrderListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['orthopaedic_subspecialties_data'] as List)
        ?.map((e) => e == null
            ? null
            : OrthopaedicSubspecialtiesListDataModel.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    (json['activities_type_data'] as List)
        ?.map((e) => e == null
            ? null
            : ActivitiesTypeListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['age_data'] == null
        ? null
        : AgeDataModel.fromJson(json['age_data'] as Map<String, dynamic>),
    json['is_fake'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MasterDataListModelToJson(
        MasterDataListModel instance) =>
    <String, dynamic>{
      'staff_data': instance.staff_data,
      'time_data': instance.time_data,
      'operative_room_data': instance.operative_room_data,
      'group_data': instance.group_data,
      'order_data': instance.order_data,
      'anesth_data': instance.anesth_data,
      'academic_type_data': instance.academic_type_data,
      'vip_data': instance.vip_data,
      'advisor_data': instance.advisor_data,
      'service_type_data': instance.service_type_data,
      'or_data': instance.or_data,
      'orthopaedic_subspecialties_data':
          instance.orthopaedic_subspecialties_data,
      'activities_type_data': instance.activities_type_data,
      'age_data': instance.age_data,
      'is_fake': instance.is_fake,
    };

AcademicTypeListDataModel _$AcademicTypeListDataModelFromJson(
    Map<String, dynamic> json) {
  return AcademicTypeListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AcademicTypeListDataModelToJson(
        AcademicTypeListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

ActivitiesTypeListDataModel _$ActivitiesTypeListDataModelFromJson(
    Map<String, dynamic> json) {
  return ActivitiesTypeListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ActivitiesTypeListDataModelToJson(
        ActivitiesTypeListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

AdvisorListDataModel _$AdvisorListDataModelFromJson(Map<String, dynamic> json) {
  return AdvisorListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AdvisorListDataModelToJson(
        AdvisorListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

AnesthListDataModel _$AnesthListDataModelFromJson(Map<String, dynamic> json) {
  return AnesthListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AnesthListDataModelToJson(
        AnesthListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

GroupListDataModel _$GroupListDataModelFromJson(Map<String, dynamic> json) {
  return GroupListDataModel(
    json['code'] as String,
    json['name'] as String,
    json['color'] as String,
  );
}

Map<String, dynamic> _$GroupListDataModelToJson(GroupListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'color': instance.color,
    };

OperativeRoomListDataModel _$OperativeRoomListDataModelFromJson(
    Map<String, dynamic> json) {
  return OperativeRoomListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$OperativeRoomListDataModelToJson(
        OperativeRoomListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

OrListDataModel _$OrListDataModelFromJson(Map<String, dynamic> json) {
  return OrListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$OrListDataModelToJson(OrListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

OrderListDataModel _$OrderListDataModelFromJson(Map<String, dynamic> json) {
  return OrderListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$OrderListDataModelToJson(OrderListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

OrthopaedicSubspecialtiesListDataModel
    _$OrthopaedicSubspecialtiesListDataModelFromJson(
        Map<String, dynamic> json) {
  return OrthopaedicSubspecialtiesListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$OrthopaedicSubspecialtiesListDataModelToJson(
        OrthopaedicSubspecialtiesListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

TimeDataModel _$TimeDataModelFromJson(Map<String, dynamic> json) {
  return TimeDataModel(
    json['min'] as String,
    json['max'] as String,
  );
}

Map<String, dynamic> _$TimeDataModelToJson(TimeDataModel instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

ServiceTypeListData _$ServiceTypeListDataFromJson(Map<String, dynamic> json) {
  return ServiceTypeListData(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ServiceTypeListDataToJson(
        ServiceTypeListData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

StaffListDataModel _$StaffListDataModelFromJson(Map<String, dynamic> json) {
  return StaffListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$StaffListDataModelToJson(StaffListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

VIPListDataModel _$VIPListDataModelFromJson(Map<String, dynamic> json) {
  return VIPListDataModel(
    json['code'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$VIPListDataModelToJson(VIPListDataModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

AgeDataModel _$AgeDataModelFromJson(Map<String, dynamic> json) {
  return AgeDataModel(
    json['min'] as int,
    json['max'] as int,
  );
}

Map<String, dynamic> _$AgeDataModelToJson(AgeDataModel instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
