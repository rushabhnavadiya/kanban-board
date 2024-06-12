import 'package:json_annotation/json_annotation.dart';

part 'add_comment_params.g.dart';

@JsonSerializable()
class AddCommentParams {

  @JsonKey(name: "task_id")
  String? taskId;
  @JsonKey(name: "content")
  String? content;

  AddCommentParams({
    this.taskId,
    this.content,
  });

  factory AddCommentParams.fromJson(Map<String, dynamic> json) => _$AddCommentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentParamsToJson(this);
}