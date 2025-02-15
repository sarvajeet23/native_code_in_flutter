import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NativePayment extends GetxService {
  static const MethodChannel _channel = MethodChannel('com.example/payment');

  static Future<String?> processPayment(double amount) async {
    try {
      final String? response = await _channel.invokeMethod('processPayment', {
        'amount': amount,
      });
      log("processPayment::$response");
      return response;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
