import 'package:fpdart/fpdart.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/core/entities/livraison_entity.dart';
import 'package:shared/core/repositories/livraison_repository.dart';
class CreateLivraisonUseCase {
  final LivraisonRepository repository;
  CreateLivraisonUseCase(this.repository);
  Future<Either<Failure, LivraisonEntity>> execute(Map<String, dynamic> body) => repository.create(body);
}
