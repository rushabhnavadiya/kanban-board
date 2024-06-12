import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/exceptions.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/data_sources/remote/tasks_impl_api.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';

class TasksRepositoryImpl extends AbstractTasksRepository {
  final TasksImplApi tasksApi;

  TasksRepositoryImpl(this.tasksApi);

  // Get All Tasks
  @override
  Future<Either<Failure, List<TaskModel>>> getTasks() async {
    try {
      final result = await tasksApi.getTasks();
      return Right(result.results ?? []);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> addTask(AddTaskParams addTaskParams) async {
    try {
      final result = await tasksApi.addTask(addTaskParams);
      return Right(result.results!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(String taskId) async {
    try {
      final result = await tasksApi.deleteTask(taskId);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStatus(UpdateStatusTaskParams param) async {
    try {
      final result = await tasksApi.updateStatus(param);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> updateTask(UpdateTaskParams param) async {
    try {
      final result = await tasksApi.updateTask(param);
      return Right(result.results!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment(AddCommentParams param) async {
    try {
      final result = await tasksApi.addComment(param);
      return Right(result.results!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(String taskId) async {
    try {
      final result = await tasksApi.getComments(taskId);
      return Right(result.results!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}