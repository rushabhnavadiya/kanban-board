import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_response_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';

abstract class AbstractTaskApi {
  // Get all tasks
  Future<ApiResponse<List<TaskModel>>> getTasks();

  // add new task
  Future<ApiResponse<TaskModel>> addTask(AddTaskParams addTaskParams);

  // delete task
  Future<ApiResponse<bool>> deleteTask(String taskId);

  // update task status
  Future<ApiResponse<void>> updateStatus(UpdateStatusTaskParams param);

  // update task
  Future<ApiResponse<void>> updateTask(UpdateTaskParams param);

  // add comment
  Future<ApiResponse<CommentModel>> addComment(AddCommentParams param);

  // get comment
  Future<ApiResponse<List<CommentModel>>> getComments(String taskId);
}