// lib/features/trips/domain/usecases/assign_bus_driver_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_boilerplate/core/shared/error_handling/failures.dart';
import 'package:project_boilerplate/core/shared/usecases/usecase_abstract.dart';
import '../repositories/trip_repository.dart';

class AssignBusAndDriverUseCase implements UseCase<bool, AssignBusDriverParams> {
  final TripRepository repository;

  AssignBusAndDriverUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AssignBusDriverParams params) async {
    return await repository.assignBusAndDriver(
      tripId: params.tripId,
      busId: params.busId,
      driverId: params.driverId,
    );
  }
}

class AssignBusDriverParams extends Equatable {
  final String tripId;
  final String busId;
  final String driverId;

  const AssignBusDriverParams({
    required this.tripId,
    required this.busId,
    required this.driverId,
  });

  @override
  List<Object> get props => [tripId, busId, driverId];
}