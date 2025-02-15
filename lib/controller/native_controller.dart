import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NativeController extends GetxController {
  static const MethodChannel _messageChannel = MethodChannel(
    'com.example/native',
  );
  static const MethodChannel _paymentChannel = MethodChannel(
    'com.example/payment',
  );

  var message = "Tap to fetch native message".obs;
  var paymentStatus = "Tap to make a payment".obs;

  /// Fetch message from Native (Kotlin)
  Future<void> getMessage() async {
    try {
      final String? result = await _messageChannel.invokeMethod('getMessage');
      log("message: $result");
      message.value = result ?? "Failed to get message!";
    } catch (e) {
      message.value = "Error: $e";
    }
  }

  /// Process payment in Native (Kotlin)
  Future<void> processPayment(double amount) async {
    try {
      final String? response = await _paymentChannel.invokeMethod(
        'processPayment',
        {'amount': amount},
      );
      log("message::$response");
      paymentStatus.value = response ?? "Payment failed!";
    } catch (e) {
      paymentStatus.value = "Error: $e";
    }
  }
}
