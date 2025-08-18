// lib/features/trips/domain/entities/driver.dart
import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String driverId;
  final String userId;
  final String name;
  final String licenseNumber;
  final int experienceYears;
  final String? currentBusId;
  final String status;
  final double rating;

  const Driver({
    required this.driverId,
    required this.userId,
    required this.name,
    required this.licenseNumber,
    required this.experienceYears,
    this.currentBusId,
    required this.status,
    required this.rating,
  });

  bool get isAvailable => status == 'available';
  bool get isAssigned => status == 'assigned';

  @override
  List<Object?> get props => [
    driverId, userId, name, licenseNumber,
    experienceYears, currentBusId, status, rating
  ];
}