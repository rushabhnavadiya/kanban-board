import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/core/utils/usecases/usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/repositories/abstract_tasks_repository.dart';

class AddNewCommentUseCase implements UseCase<CommentModel, AddCommentParams> {
  AddNewCommentUseCase(this.taskRepository);
  final AbstractTasksRepository taskRepository;

  @override
  Future<Either<Failure, CommentModel>> call(AddCommentParams param) {
    return taskRepository.addComment(param);
  }
}