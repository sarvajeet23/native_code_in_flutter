package com.example.native_code_in_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val MESSAGE_CHANNEL = "com.example/native"
        private const val PAYMENT_CHANNEL = "com.example/payment"
        private const val LOCATION_CHANNEL = "com.example/location"
        private const val GEOFENCE_CHANNEL = "com.example/geofence"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ✅ Setup NativeMessage channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MESSAGE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getMessage" -> {
                        val message = call.argument<String>("message") ?: "Default Message"
                        result.success(NativeMessage().getMessage(message))
                    }
                    else -> result.notImplemented()
                }
            }

        // ✅ Setup Payment channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PAYMENT_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "processPayment" -> {
                        val amount = call.argument<Double>("amount")
                        if (amount == null || amount <= 0.0) {
                            result.error("INVALID_AMOUNT", "Invalid payment amount", null)
                        } else {
                            val response = Payment(this).processPayment(amount)
                            result.success(response)
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        // ✅ Setup Location channel using LocationHelper
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LOCATION_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getLocation" -> {
                        val locationHelper = LocationHelper(this)
                        locationHelper.getLocation { location ->
                            if (location != null) {
                                result.success(location)
                            } else {
                                result.error("LOCATION_ERROR", "Failed to retrieve location", null)
                            }
                        }
                    }
                    else -> result.notImplemented()
                }
            }

        // ✅ Setup Geofencing channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GEOFENCE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "addGeofence" -> {
                        val lat = call.argument<Double>("latitude")
                        val lng = call.argument<Double>("longitude")
                        if (lat != null && lng != null) {
                            GeofenceHelper(this).addGeofence(lat, lng)
                            result.success("Geofence added at ($lat, $lng)")
                        } else {
                            result.error("INVALID_INPUT", "Invalid coordinates", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
