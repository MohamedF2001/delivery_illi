import 'package:fpdart/fpdart.dart';
import 'package:shared/core/errors/failures.dart';
import 'package:shared/core/entities/vehicule_entity.dart';
import 'package:shared/core/repositories/vehicule_repository.dart';

class GetVehiculesUseCase {
  final VehiculeRepository repository;
  GetVehiculesUseCase(this.repository);
  Future<Either<Failure, List<VehiculeEntity>>> execute({bool? actif}) => repository.getAll(actif: actif);
}
