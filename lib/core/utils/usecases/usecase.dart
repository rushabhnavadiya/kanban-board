import 'package:dartz/dartz.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}