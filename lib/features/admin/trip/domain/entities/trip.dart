// lib/features/trips/domain/entities/trip.dart
import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final String tripId;
  final String tripName;
  final String busId;
  final String driverId;
  final String date;
  final String startTime;
  final String endTime;
  final String status;
  final int totalPassengers;
  final String routeId;

  const Trip({
    required this.tripId,
    required this.tripName,
    required this.busId,
    required this.driverId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.totalPassengers,
    required this.routeId,
  });

  // Copy with method
  Trip copyWith({
    String? tripId,
    String? tripName,
    String? busId,
    String? driverId,
    String? date,
    String? startTime,
    String? endTime,
    String? status,
    int? totalPassengers,
    String? routeId,
  }) {
    return Trip(
      tripId: tripId ?? this.tripId,
      tripName: tripName ?? this.tripName,
      busId: busId ?? this.busId,
      driverId: driverId ?? this.driverId,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      totalPassengers: totalPassengers ?? this.totalPassengers,
      routeId: routeId ?? this.routeId,
    );
  }

  // Status helpers
  bool get isScheduled => status == 'scheduled';
  bool get isInProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object> get props => [
    tripId, tripName, busId, driverId, date,
    startTime, endTime, status, totalPassengers, routeId
  ];
}