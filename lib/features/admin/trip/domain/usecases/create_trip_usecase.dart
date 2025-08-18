// lib/features/trips/domain/usecases/create_trip_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_boilerplate/core/shared/error_handling/failures.dart';
import 'package:project_boilerplate/core/shared/usecases/usecase_abstract.dart';
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

class CreateTripUseCase implements UseCase<Trip, CreateTripParams> {
  final TripRepository repository;

  CreateTripUseCase(this.repository);

  @override
  Future<Either<Failure, Trip>> call(CreateTripParams params) async {
    // Validate inputs
    if (params.tripName.isEmpty) {
      return Left(ValidationFailure('Trip name is required'));
    }

    if (params.date.isEmpty) {
      return Left(ValidationFailure('Date is required'));
    }

    // Check if start time is before end time
    final startTime = DateTime.parse('2024-01-01 ${params.startTime}');
    final endTime = DateTime.parse('2024-01-01 ${params.endTime}');

    if (startTime.isAfter(endTime)) {
      return Left(ValidationFailure('Start time must be before end time'));
    }

    return await repository.createTrip(
      tripName: params.tripName,
      busId: params.busId,
      driverId: params.driverId,
      date: params.date,
      startTime: params.startTime,
      endTime: params.endTime,
      routeId: params.routeId,
    );
  }
}

class CreateTripParams extends Equatable {
  final String tripName;
  final String busId;
  final String driverId;
  final String date;
  final String startTime;
  final String endTime;
  final String routeId;

  const CreateTripParams({
    required this.tripName,
    required this.busId,
    required this.driverId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.routeId,
  });

  @override
  List<Object> get props => [
    tripName, busId, driverId, date,
    startTime, endTime, routeId
  ];
}