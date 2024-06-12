import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/core/utils/usecases/usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';

class UpdateTaskUseCase implements UseCase<TaskModel, UpdateTaskParams> {
  UpdateTaskUseCase(this.taskRepository);
  final AbstractTasksRepository taskRepository;

  @override
  Future<Either<Failure, TaskModel>> call(UpdateTaskParams param) {
    return taskRepository.updateTask(param);
  }
}