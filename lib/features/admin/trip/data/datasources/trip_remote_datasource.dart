// // lib/features/trips/data/datasources/trip_remote_datasource.dart
// import '../models/trip_model.dart';
//
// abstract class TripRemoteDataSource {
//   Future<List<TripModel>> getAllTrips({String? date, String? status});
//   Future<TripModel> createTrip({
//     required String tripName,
//     required String busId,
//     required String driverId,
//     required String date,
//     required String startTime,
//     required String endTime,
//     required String routeId,
//   });
//   Future<bool> assignBusAndDriver({
//     required String tripId,
//     required String busId,
//     required String driverId,
//   });
//   Future<bool> updateTripStatus({
//     required String tripId,
//     required String status,
//   });
//   Future<bool> deleteTrip(String tripId);
//   Future<List<BusModel>> getAllBuses();
//   Future<BusModel> createBus({
//     required String busNumber,
//     required int capacity,
//     required String model,
//     required String licensePlate,
//   });
//   Future<bool> updateBus({
//     required String busId,
//     required Map<String, dynamic> updates,
//   });
//   Future<bool> deleteBus(String busId);
//   Future<List<DriverModel>> getAllDrivers();
// }
//
// class TripRemoteDataSourceImpl implements TripRemoteDataSource {
//   final DioService dioService;
//   static const String apiKey = 'tr4nsp0rt_2024_s3cur3_k3y';
//
//   TripRemoteDataSourceImpl({required this.dioService});
//
//   @override
//   Future<List<TripModel>> getAllTrips({String? date, String? status}) async {
//     final queryParams = {
//       'path': 'trips',
//       'apiKey': apiKey,
//       if (date != null) 'date': date,
//       if (status != null) 'status': status,
//     };
//
//     final response = await dioService.get<Map<String, dynamic>>(
//       path: '',
//       queryParameters: queryParams,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     if (response.success && response.data != null) {
//       final data = response.data!['data'];
//       if (data is List) {
//         return data.map((json) => TripModel.fromJson(json)).toList();
//       }
//     }
//
//     throw Exception(response.message ?? 'Failed to fetch trips');
//   }
//
//   @override
//   Future<TripModel> createTrip({
//     required String tripName,
//     required String busId,
//     required String driverId,
//     required String date,
//     required String startTime,
//     required String endTime,
//     required String routeId,
//   }) async {
//     final body = {
//       'apiKey': apiKey,
//       'tripName': tripName,
//       'busId': busId,
//       'driverId': driverId,
//       'date': date,
//       'startTime': startTime,
//       'endTime': endTime,
//       'routeId': routeId,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'create-trip', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     if (response.success && response.data != null) {
//       final tripData = response.data!['data']['trip'];
//       return TripModel.fromJson(tripData);
//     }
//
//     throw Exception(response.message ?? 'Failed to create trip');
//   }
//
//   @override
//   Future<bool> assignBusAndDriver({
//     required String tripId,
//     required String busId,
//     required String driverId,
//   }) async {
//     final body = {
//       'apiKey': apiKey,
//       'tripId': tripId,
//       'busId': busId,
//       'driverId': driverId,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'assign-bus-driver', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     return response.success;
//   }
//
//   @override
//   Future<bool> updateTripStatus({
//     required String tripId,
//     required String status,
//   }) async {
//     // Implement based on your API endpoint
//     // For now, this is a placeholder
//     final body = {
//       'apiKey': apiKey,
//       'tripId': tripId,
//       'status': status,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'update-trip-status', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     return response.success;
//   }
//
//   @override
//   Future<bool> deleteTrip(String tripId) async {
//     final body = {
//       'apiKey': apiKey,
//       'tripId': tripId,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'delete-trip', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     return response.success;
//   }
//
//   @override
//   Future<List<BusModel>> getAllBuses() async {
//     // Implement based on your API
//     final queryParams = {
//       'path': 'buses',
//       'apiKey': apiKey,
//     };
//
//     final response = await dioService.get<Map<String, dynamic>>(
//       path: '',
//       queryParameters: queryParams,
//       showLoading: false,
//       requireAuth: false,
//     );
//
//     if (response.success && response.data != null) {
//       final data = response.data!['data'];
//       if (data is List) {
//         return data.map((json) => BusModel.fromJson(json)).toList();
//       }
//     }
//
//     throw Exception(response.message ?? 'Failed to fetch buses');
//   }
//
//   @override
//   Future<BusModel> createBus({
//     required String busNumber,
//     required int capacity,
//     required String model,
//     required String licensePlate,
//   }) async {
//     final body = {
//       'apiKey': apiKey,
//       'busNumber': busNumber,
//       'capacity': capacity,
//       'model': model,
//       'licensePlate': licensePlate,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'create-bus', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     if (response.success && response.data != null) {
//       final busData = response.data!['data']['bus'];
//       return BusModel.fromJson(busData);
//     }
//
//     throw Exception(response.message ?? 'Failed to create bus');
//   }
//
//   @override
//   Future<bool> updateBus({
//     required String busId,
//     required Map<String, dynamic> updates,
//   }) async {
//     final body = {
//       'apiKey': apiKey,
//       'busId': busId,
//       'updates': updates,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'update-bus', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     return response.success;
//   }
//
//   @override
//   Future<bool> deleteBus(String busId) async {
//     final body = {
//       'apiKey': apiKey,
//       'busId': busId,
//     };
//
//     final response = await dioService.post<Map<String, dynamic>>(
//       path: '',
//       queryParameters: {'path': 'delete-bus', 'apiKey': apiKey},
//       data: body,
//       showLoading: true,
//       requireAuth: false,
//     );
//
//     return response.success;
//   }
//
//   @override
//   Future<List<DriverModel>> getAllDrivers() async {
//     // Implement based on your API
//     final queryParams = {
//       'path': 'drivers',
//       'apiKey': apiKey,
//     };
//
//     final response = await dioService.get<Map<String, dynamic>>(
//       path: '',
//       queryParameters: queryParams,
//       showLoading: false,
//       requireAuth: false,
//     );
//
//     if (response.success && response.data != null) {
//       final data = response.data!['data'];
//       if (data is List) {
//         return data.map((json) => DriverModel.fromJson(json)).toList();
//       }
//     }
//
//     throw Exception(response.message ?? 'Failed to fetch drivers');
//   }
// }