import 'package:flutter/foundation.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.status,
    required this.message,
    required this.results,
  });

  late final bool? status;
  late final String? message;
  late final T? results;

  static fromJson<T>(dynamic json, Function tFromJson) {
    return ApiResponse<T>(
      status: true,
      message: "",
      results: tFromJson(json),
    );
  }
  static result<bool>(bool value) {
    return ApiResponse<bool>(
      status: true,
      message: "",
      results: value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ApiResponse) {
      return other.results is List
          ? listEquals(other.results, results as List)
          : other.results == results;
    }

    return false;
  }
}