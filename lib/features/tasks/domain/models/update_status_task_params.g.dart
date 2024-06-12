// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_status_task_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatusTaskParams _$UpdateStatusTaskParamsFromJson(
        Map<String, dynamic> json) =>
    UpdateStatusTaskParams(
      taskId: json['task_id'] as String?,
      sectionId: json['section_id'] as String?,
    );

Map<String, dynamic> _$UpdateStatusTaskParamsToJson(
        UpdateStatusTaskParams instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'section_id': instance.sectionId,
    };
