import 'package:json_annotation/json_annotation.dart';

part 'add_task_params.g.dart';

@JsonSerializable()
class AddTaskParams {
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "priority")
  int? priority;
  @JsonKey(name: "section_id")
  String? sectionId;

  AddTaskParams({
    this.content,
    this.description,
    this.priority,
    this.sectionId,
  });

  factory AddTaskParams.fromJson(Map<String, dynamic> json) => _$AddTaskParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskParamsToJson(this);
}
