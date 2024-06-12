import 'package:json_annotation/json_annotation.dart';

part 'update_status_task_params.g.dart';

@JsonSerializable()
class UpdateStatusTaskParams {

  @JsonKey(name: "task_id")
  String? taskId;
  @JsonKey(name: "section_id")
  String? sectionId;

  UpdateStatusTaskParams({
    this.taskId,
    this.sectionId,
  });

  factory UpdateStatusTaskParams.fromJson(Map<String, dynamic> json) => _$UpdateStatusTaskParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStatusTaskParamsToJson(this);
}
