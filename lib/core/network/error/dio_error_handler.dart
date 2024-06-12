import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  String errorDescription = "";

  switch (error.type) {
    case DioExceptionType.cancel:
      errorDescription = "Request to API server was cancelled";
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription = "Internet Connection Problem.";
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioExceptionType.badResponse:
      errorDescription = "Received invalid status code: ${error.response?.statusCode} ${error.response?.statusMessage}";
      break;

    case DioExceptionType.sendTimeout:
      errorDescription = "Send timeout in connection with API server";
      break;
    case DioExceptionType.badCertificate:
    // TODO: Handle this case.
      break;
    case DioExceptionType.connectionError:
    // TODO: Handle this case.
      break;
    case DioExceptionType.unknown:
    // TODO: Handle this case.
      break;
  }

  return errorDescription;
}