import 'package:fpdart/fpdart.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/core/repositories/livraison_repository.dart';
class EstimatePriceUseCase {
  final LivraisonRepository repository;
  EstimatePriceUseCase(this.repository);
  Future<Either<Failure, Map<String, dynamic>>> execute(Map<String, dynamic> body) => repository.estimatePrice(body);
}
