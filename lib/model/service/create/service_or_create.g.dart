// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_or_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCreateModel _$ServiceCreateModelFromJson(Map<String, dynamic> json) {
  return ServiceCreateModel(
    schedule_start_date: json['schedule_start_date'] as String,
    schedule_start_time: json['schedule_start_time'] as String,
    schedule_end_date: json['schedule_end_date'] as String,
    schedule_end_time: json['schedule_end_time'] as String,
    service_type_code: json['service_type_code'] as String,
    groups_code: json['groups_code'] as String,
    or_code: json['or_code'] as String,
    staff_code: json['staff_code'] as String,
    resident: json['resident'] as String,
    intern: json['intern'] as String,
    chief_r: json['chief_r'] as String,
    orthopaedic_subspecialties_code:
        json['orthopaedic_subspecialties_code'] as String,
    r_4: json['r_4'] as String,
    r_3: json['r_3'] as String,
    r_2: json['r_2'] as String,
    r_1: json['r_1'] as String,
    er_daytime: json['er_daytime'] as String,
  );
}

Map<String, dynamic> _$ServiceCreateModelToJson(ServiceCreateModel instance) =>
    <String, dynamic>{
      'schedule_start_date': instance.schedule_start_date,
      'schedule_start_time': instance.schedule_start_time,
      'schedule_end_date': instance.schedule_end_date,
      'schedule_end_time': instance.schedule_end_time,
      'service_type_code': instance.service_type_code,
      'groups_code': instance.groups_code,
      'or_code': instance.or_code,
      'staff_code': instance.staff_code,
      'resident': instance.resident,
      'intern': instance.intern,
      'chief_r': instance.chief_r,
      'orthopaedic_subspecialties_code':
          instance.orthopaedic_subspecialties_code,
      'r_4': instance.r_4,
      'r_3': instance.r_3,
      'r_2': instance.r_2,
      'r_1': instance.r_1,
      'er_daytime': instance.er_daytime,
    };
