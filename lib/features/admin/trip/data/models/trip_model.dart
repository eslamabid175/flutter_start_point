// lib/features/trips/data/models/trip_model.dart
import '../../domain/entities/trip.dart';

class TripModel extends Trip {
  const TripModel({
    required String tripId,
    required String tripName,
    required String busId,
    required String driverId,
    required String date,
    required String startTime,
    required String endTime,
    required String status,
    required int totalPassengers,
    required String routeId,
  }) : super(
    tripId: tripId,
    tripName: tripName,
    busId: busId,
    driverId: driverId,
    date: date,
    startTime: startTime,
    endTime: endTime,
    status: status,
    totalPassengers: totalPassengers,
    routeId: routeId,
  );

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      tripId: json['trip_id'] ?? '',
      tripName: json['trip_name'] ?? '',
      busId: json['bus_id'] ?? '',
      driverId: json['driver_id'] ?? '',
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      status: json['status'] ?? 'scheduled',
      totalPassengers: int.tryParse(json['total_passengers']?.toString() ?? '0') ?? 0,
      routeId: json['route_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId,
      'trip_name': tripName,
      'bus_id': busId,
      'driver_id': driverId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'status': status,
      'total_passengers': totalPassengers,
      'route_id': routeId,
    };
  }
}