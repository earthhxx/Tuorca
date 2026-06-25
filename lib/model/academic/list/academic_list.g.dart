// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicListModel _$AcademicListModelFromJson(Map<String, dynamic> json) {
  return AcademicListModel(
    json['statusCode'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AcademicListDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AcademicListModelToJson(AcademicListModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };

AcademicListDataModel _$AcademicListDataModelFromJson(
    Map<String, dynamic> json) {
  return AcademicListDataModel(
    json['academic_id'] as String,
    json['academic_type_name'] as String,
    json['title'] as String,
    json['presenter_1'] as String,
    json['advisor_name'] as String,
    json['schedule_start_datetime'] as String,
    json['schedule_end_datetime'] as String,
  );
}

Map<String, dynamic> _$AcademicListDataModelToJson(
        AcademicListDataModel instance) =>
    <String, dynamic>{
      'academic_id': instance.academic_id,
      'academic_type_name': instance.academic_type_name,
      'title': instance.title,
      'presenter_1': instance.presenter_1,
      'advisor_name': instance.advisor_name,
      'schedule_start_datetime': instance.schedule_start_datetime,
      'schedule_end_datetime': instance.schedule_end_datetime,
    };
