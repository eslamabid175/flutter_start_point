// lib/features/trips/domain/usecases/get_all_trips_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_boilerplate/core/shared/error_handling/failures.dart';
import 'package:project_boilerplate/core/shared/usecases/usecase_abstract.dart';
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class GetAllTripsUseCase implements UseCase<List<Trip>, GetTripsParams> {
  final TripRepository repository;

  GetAllTripsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Trip>>> call(GetTripsParams params) async {
    return await repository.getAllTrips(
      date: params.date,
      status: params.status,
    );
  }
}

class GetTripsParams extends Equatable {
  final String? date;
  final String? status;

  const GetTripsParams({
    this.date,
    this.status,
  });

  @override
  List<Object?> get props => [date, status];
}