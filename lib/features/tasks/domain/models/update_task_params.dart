import 'package:json_annotation/json_annotation.dart';

part 'update_task_params.g.dart';

@JsonSerializable()
class UpdateTaskParams {

  @JsonKey(name: "task_id")
  String? taskId;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "priority")
  int? priority;

  UpdateTaskParams({
    this.taskId,
    this.content,
    this.description,
    this.priority
  });

  factory UpdateTaskParams.fromJson(Map<String, dynamic> json) => _$UpdateTaskParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTaskParamsToJson(this);
}
