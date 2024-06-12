// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskParams _$AddTaskParamsFromJson(Map<String, dynamic> json) =>
    AddTaskParams(
      content: json['content'] as String?,
      description: json['description'] as String?,
      priority: (json['priority'] as num?)?.toInt(),
      sectionId: json['section_id'] as String?,
    );

Map<String, dynamic> _$AddTaskParamsToJson(AddTaskParams instance) =>
    <String, dynamic>{
      'content': instance.content,
      'description': instance.description,
      'priority': instance.priority,
      'section_id': instance.sectionId,
    };
