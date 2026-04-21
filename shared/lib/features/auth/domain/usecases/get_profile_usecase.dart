import 'package:fpdart/fpdart.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/core/entities/user_entity.dart';
import 'package:shared/core/repositories/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;
  GetProfileUseCase(this.repository);
  Future<Either<Failure, UserEntity>> execute() => repository.getProfile();
}
