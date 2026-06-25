import 'package:json_annotation/json_annotation.dart';
import 'package:tuoc/model/base_model.dart';

part 'academic_list.g.dart';

@JsonSerializable()
class AcademicListModel extends BaseModel {
  final List<AcademicListDataModel> data;

  AcademicListModel(int statusCode, String message, this.data)
      : super(statusCode, message);

  factory AcademicListModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicListModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicListModelToJson(this);
}

@JsonSerializable()
class AcademicListDataModel {
  final String academic_id;
  final String academic_type_name;
  final String title;
  final String presenter_1;
  final String advisor_name;
  final String schedule_start_datetime;
  final String schedule_end_datetime;

  AcademicListDataModel(
      this.academic_id,
      this.academic_type_name,
      this.title,
      this.presenter_1,
      this.advisor_name,
      this.schedule_start_datetime,
      this.schedule_end_datetime);

  factory AcademicListDataModel.fromJson(Map<String, dynamic> json) =>
      _$AcademicListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicListDataModelToJson(this);
}
