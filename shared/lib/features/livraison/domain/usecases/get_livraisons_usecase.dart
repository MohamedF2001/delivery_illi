import 'package:fpdart/fpdart.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/core/entities/livraison_entity.dart';
import 'package:shared/core/repositories/livraison_repository.dart';
class GetLivraisonsUseCase {
  final LivraisonRepository repository;
  GetLivraisonsUseCase(this.repository);
  Future<Either<Failure, List<LivraisonEntity>>> execute({Map<String, dynamic>? filters}) => repository.getAll(filters: filters);
}
