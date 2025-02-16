import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationHelper {
  static const MethodChannel _channel = MethodChannel('com.example/location');

  static Future<String?> getLocation() async {
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) return "PERMISSION_DENIED";

    try {
      final String? location = await _channel.invokeMethod('getLocation');
      return location;
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }
}
