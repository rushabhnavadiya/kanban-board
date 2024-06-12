// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackTimeModel _$TrackTimeModelFromJson(Map<String, dynamic> json) =>
    TrackTimeModel(
      taskId: json['task_id'] as String,
      times:
          (json['times'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TrackTimeModelToJson(TrackTimeModel instance) =>
    <String, dynamic>{
      'task_id': instance.taskId,
      'times': instance.times,
    };
