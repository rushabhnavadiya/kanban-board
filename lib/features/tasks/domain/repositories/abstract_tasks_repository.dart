import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';

abstract class AbstractTasksRepository {
  // Get all tasks
  Future<Either<Failure, List<TaskModel>>> getTasks();

  // add new task
  Future<Either<Failure, TaskModel>> addTask(AddTaskParams addTaskParams);

  // delete task
  Future<Either<Failure, bool>> deleteTask(String taskId);

  // update task status
  Future<Either<Failure, bool>> updateStatus(UpdateStatusTaskParams param);

  // update task detail
  Future<Either<Failure, TaskModel>> updateTask(UpdateTaskParams param);

  // add comment
  Future<Either<Failure, CommentModel>> addComment(AddCommentParams param);

  // get comments
  Future<Either<Failure, List<CommentModel>>> getComments(String taskId);
}