import 'package:dio/dio.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/dio_error_handler.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/exceptions.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/network_constant.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/data_sources/remote/abstract_task_api.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_response_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';
import 'package:uuid/uuid.dart';

class TasksImplApi extends AbstractTaskApi {
  final Dio dio;

  CancelToken cancelToken = CancelToken();

  TasksImplApi(this.dio);

  // Tasks Method
  @override
  Future<ApiResponse<List<TaskModel>>> getTasks() async {
    try {
      final result = await dio.get("${apiUrl}rest/v2/tasks");
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return ApiResponse.fromJson<List<TaskModel>>(
          result.data, TaskModel.fromJsonList);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<TaskModel>> addTask(AddTaskParams addTaskParams) async {
    try {
      final result = await dio.post("${apiUrl}rest/v2/tasks",
          data: addTaskParams.toJson());
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }

      return ApiResponse.fromJson<TaskModel>(result.data, TaskModel.fromJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<bool>> deleteTask(String taskId) async {
    try {
      final result = await dio.delete("${apiUrl}tasks/$taskId");
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }

      return ApiResponse.result(true);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<bool>> updateStatus(UpdateStatusTaskParams param) async {
    try {
      var uuid = const Uuid();
      String id = uuid.v1();
      var data = {
        'commands': '[\n    {\n        "type": "item_move", \n        "uuid": "$id", \n        "args": {\n            "id": "${param.taskId}", \n            "section_id": "${param.sectionId}"\n        }\n    }]'
      };
      final result = await dio.post("${apiUrl}sync/v9/sync",
          data: data);
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return ApiResponse.result(true);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<TaskModel>> updateTask(UpdateTaskParams param) async {
    try {
      final result = await dio.post("${apiUrl}tasks/${param.taskId}",
          data: param.toJson()..removeWhere((key, value) => key == "task_id"));
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return ApiResponse.fromJson<TaskModel>(result.data, TaskModel.fromJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<CommentModel>> addComment(AddCommentParams param) async {
    try {
      final result = await dio.post("${apiUrl}rest/v2/comments",
          data: param.toJson());
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }

      return ApiResponse.fromJson<CommentModel>(result.data, CommentModel.fromJson);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse<List<CommentModel>>> getComments(String taskId) async {
    try {
      final result = await dio.get("${apiUrl}rest/v2/comments?task_id=$taskId");
      if (result.data == null) {
        throw ServerException("Unknown Error", result.statusCode);
      }
      return ApiResponse.fromJson<List<CommentModel>>(
          result.data, CommentModel.fromJsonList);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
  }
}