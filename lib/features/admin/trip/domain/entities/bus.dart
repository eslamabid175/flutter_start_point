// lib/features/trips/domain/entities/bus.dart
import 'package:equatable/equatable.dart';

class Bus extends Equatable {
  final String busId;
  final String busNumber;
  final int capacity;
  final String model;
  final String licensePlate;
  final String status;
  final String? driverId;

  const Bus({
    required this.busId,
    required this.busNumber,
    required this.capacity,
    required this.model,
    required this.licensePlate,
    required this.status,
    this.driverId,
  });

  bool get isActive => status == 'active';
  bool get isAvailable => driverId == null || driverId!.isEmpty;

  @override
  List<Object?> get props => [
    busId, busNumber, capacity, model,
    licensePlate, status, driverId
  ];
}