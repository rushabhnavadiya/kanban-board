// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentParams _$AddCommentParamsFromJson(Map<String, dynamic> json) =>
    AddCommentParams(
      taskId: json['task_id'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$AddCommentParamsToJson(AddCommentParams instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'content': instance.content,
    };
