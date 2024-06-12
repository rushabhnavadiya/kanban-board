import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/core/utils/usecases/usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';


class AddNewTaskUseCase implements UseCase<TaskModel, AddTaskParams> {
  AddNewTaskUseCase(this.taskRepository);
  final AbstractTasksRepository taskRepository;

  @override
  Future<Either<Failure, TaskModel>> call(AddTaskParams param) {
    return taskRepository.addTask(param);
  }
}