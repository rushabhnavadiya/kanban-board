import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/core/utils/usecases/usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';

class DeleteTaskUseCase implements UseCase<bool, String> {
  DeleteTaskUseCase(this.taskRepository);
  final AbstractTasksRepository taskRepository;

  @override
  Future<Either<Failure, bool>> call(String taskId) {
    return taskRepository.deleteTask(taskId);
  }
}