import 'package:take_home_challenge_innoscripta/core/network/dio_network.dart';
import 'package:take_home_challenge_innoscripta/core/utils/injections.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/data_sources/local/tasks_shared_prefs.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/data_sources/remote/tasks_impl_api.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/repositories/tasks_repo_impl.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_comment_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_task_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_comments_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_status_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_task_use_case.dart';

initTasksInjections() {

  sl.registerSingleton<TasksImplApi>(TasksImplApi(DioNetwork.appAPI));
  sl.registerSingleton<AbstractTasksRepository>(TasksRepositoryImpl(sl()));
  sl.registerSingleton<TasksSharedPrefs>(TasksSharedPrefs(sl()));

  sl.registerSingleton<AddNewTaskUseCase>(AddNewTaskUseCase(sl()));
  sl.registerSingleton<DeleteTaskUseCase>(DeleteTaskUseCase(sl()));
  sl.registerSingleton<GetTasksUseCase>(GetTasksUseCase(sl()));
  sl.registerSingleton<UpdateStatusTaskUseCase>(UpdateStatusTaskUseCase(sl()));
  sl.registerSingleton<UpdateTaskUseCase>(UpdateTaskUseCase(sl()));
  sl.registerSingleton<AddNewCommentUseCase>(AddNewCommentUseCase(sl()));
  sl.registerSingleton<GetCommentsUseCase>(GetCommentsUseCase(sl()));
}