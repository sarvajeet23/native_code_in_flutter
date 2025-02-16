import 'dart:developer';

import 'package:get/get.dart';
import 'package:native_code_in_flutter/utility/geofence_helper.dart';
import 'package:native_code_in_flutter/utility/location_helper.dart';

class LocationController extends GetxController {
  var currentLocation = "".obs;
  var geofenceStatus = "".obs;

  Future<void> fetchLocation() async {
    String? location = await LocationHelper.getLocation();
    log("message$location");
    currentLocation.value = location ?? "Location error";
  }

  Future<void> addGeofence(double lat, double lng) async {
    String? status = await GeofenceHelper.addGeofence(lat, lng);
    geofenceStatus.value = status ?? "Geofence error";
  }
}
