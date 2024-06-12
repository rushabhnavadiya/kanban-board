// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_task_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTaskParams _$UpdateTaskParamsFromJson(Map<String, dynamic> json) =>
    UpdateTaskParams(
      taskId: json['task_id'] as String?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      priority: (json['priority'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateTaskParamsToJson(UpdateTaskParams instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'content': instance.content,
      'description': instance.description,
      'priority': instance.priority,
    };
