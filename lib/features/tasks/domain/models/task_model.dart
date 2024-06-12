import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  @JsonKey(name: "creator_id")
  String? creatorId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "assignee_id")
  String? assigneeId;
  @JsonKey(name: "assigner_id")
  String? assignerId;
  @JsonKey(name: "comment_count")
  int? commentCount;
  @JsonKey(name: "is_completed")
  bool? isCompleted;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "due")
  Due? due;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "labels")
  List<String>? labels;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "priority")
  int? priority;
  @JsonKey(name: "project_id")
  String? projectId;
  @JsonKey(name: "section_id")
  String? sectionId;
  @JsonKey(name: "parent_id")
  String? parentId;
  @JsonKey(name: "url")
  String? url;

  TaskModel({
    this.creatorId,
    this.createdAt,
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.isCompleted,
    this.content,
    this.description,
    this.due,
    this.duration,
    this.id,
    this.labels,
    this.order,
    this.priority,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.url,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);


  static List<TaskModel> fromJsonList(dynamic json) {
    return (json as List<dynamic>).map((e) => TaskModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}

@JsonSerializable()
class Due {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "is_recurring")
  bool? isRecurring;
  @JsonKey(name: "datetime")
  String? datetime;
  @JsonKey(name: "string")
  String? string;
  @JsonKey(name: "timezone")
  String? timezone;

  Due({
    this.date,
    this.isRecurring,
    this.datetime,
    this.string,
    this.timezone,
  });

  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);

  Map<String, dynamic> toJson() => _$DueToJson(this);
}
enum TaskStatus {
  todo,
  inProgress,
  done,
}
