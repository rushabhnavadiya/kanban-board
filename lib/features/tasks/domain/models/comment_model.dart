import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "posted_at")
  String? postedAt;
  @JsonKey(name: "project_id")
  dynamic projectId;
  @JsonKey(name: "task_id")
  String? taskId;
  @JsonKey(name: "attachment")
  Attachment? attachment;

  CommentModel({
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);


  static List<CommentModel> fromJsonList(dynamic json) {
    return (json as List<dynamic>).map((e) => CommentModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

@JsonSerializable()
class Attachment {
  @JsonKey(name: "file_name")
  String? fileName;
  @JsonKey(name: "file_type")
  String? fileType;
  @JsonKey(name: "file_url")
  String? fileUrl;
  @JsonKey(name: "resource_type")
  String? resourceType;

  Attachment({
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.resourceType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
