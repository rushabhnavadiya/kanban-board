
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'track_time_model.g.dart';

@JsonSerializable()
class TrackTimeModel {
  @JsonKey(name: "task_id")
  String taskId;
  @JsonKey(name: "times")
  List<String> times;

  TrackTimeModel({
    required this.taskId,
    required this.times,
  });

  factory TrackTimeModel.fromJson(Map<String, dynamic> json) => _$TrackTimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrackTimeModelToJson(this);
  static List<TrackTimeModel> trackTimeModelsFromJson(String str) => List<TrackTimeModel>.from(json.decode(str).map((x) => TrackTimeModel.fromJson(x)));

  static String trackTimeModelsToJson(List<TrackTimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

}