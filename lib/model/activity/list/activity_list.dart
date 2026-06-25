import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'activity_list.g.dart';

@JsonSerializable()
class ActivityListModel extends BaseModel {
  final List<ActivityListDataModel> data;

  ActivityListModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory ActivityListModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityListModelToJson(this);
}

@JsonSerializable()
class ActivityListDataModel {
  final String activity_id;
  final String activity_type_code_name;
  final String title;
  final String presenter_1;
  final String venue;
  final String schedule_start_datetime;
  final String schedule_end_datetime;

  ActivityListDataModel(
      this.activity_id,
      this.activity_type_code_name,
      this.title,
      this.presenter_1,
      this.venue,
      this.schedule_start_datetime,
      this.schedule_end_datetime);

  factory ActivityListDataModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityListDataModelToJson(this);
}
