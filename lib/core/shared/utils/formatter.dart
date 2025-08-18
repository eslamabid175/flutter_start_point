import 'package:intl/intl.dart';

// Helper function to format DateTime to Date string
String formatDate(DateTime dateTime) {
  final dateFormat = DateFormat('dd/MM/yyyy'); // Date: 22/10/2024
  return dateFormat.format(dateTime);
}

// Helper function to format DateTime to Time string
String formatTime(DateTime dateTime) {
  final timeFormat = DateFormat.jm(); // Time: 2:00 AM
  return timeFormat.format(dateTime);
}
