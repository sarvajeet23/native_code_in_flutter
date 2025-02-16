import 'dart:developer';
import 'package:flutter/services.dart';

class GeofenceHelper {
  static const MethodChannel _channel = MethodChannel('com.example/geofence');

  static Future<String?> addGeofence(double latitude, double longitude) async {
    try {
      final String? response = await _channel.invokeMethod('addGeofence', {
        'latitude': latitude,
        'longitude': longitude,
      });
      log("addGeofence::$response");
      return response;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
