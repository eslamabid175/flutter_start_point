// lib/features/trips/domain/repositories/trip_repository.dart
import 'package:dartz/dartz.dart';
import 'package:project_boilerplate/core/shared/error_handling/failures.dart';
import '../entities/trip.dart';
import '../entities/bus.dart';
import '../entities/driver.dart';

abstract class TripRepository {
  // Trip Management
  Future<Either<Failure, List<Trip>>> getAllTrips({
    String? date,
    String? status,
  });

  Future<Either<Failure, Trip>> createTrip({
    required String tripName,
    required String busId,
    required String driverId,
    required String date,
    required String startTime,
    required String endTime,
    required String routeId,
  });

  Future<Either<Failure, bool>> assignBusAndDriver({
    required String tripId,
    required String busId,
    required String driverId,
  });

  Future<Either<Failure, bool>> updateTripStatus({
    required String tripId,
    required String status,
  });

  Future<Either<Failure, bool>> deleteTrip(String tripId);

  // Bus Management
  Future<Either<Failure, List<Bus>>> getAllBuses();

  Future<Either<Failure, Bus>> createBus({
    required String busNumber,
    required int capacity,
    required String model,
    required String licensePlate,
  });

  Future<Either<Failure, bool>> updateBus({
    required String busId,
    required Map<String, dynamic> updates,
  });

  Future<Either<Failure, bool>> deleteBus(String busId);

  // Driver Management
  Future<Either<Failure, List<Driver>>> getAllDrivers();

  Future<Either<Failure, List<Driver>>> getAvailableDrivers();

  Future<Either<Failure, List<Bus>>> getAvailableBuses();
}