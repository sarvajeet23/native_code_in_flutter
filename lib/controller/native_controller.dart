import 'dart:developer';

import 'package:get/get.dart';
import 'package:native_code_in_flutter/utility/native_payment.dart';

import '../utility/native_helper_massage.dart';

class NativeController extends GetxController {
  var messages = "".obs;
  var paymentStatus = "".obs;

  /// Submit form: Send message & process payment
  void submit(String message, double payment) async {
    try {
      final messageResponse = NativeHelperMassage.getNativeMessage(message);
      messages.value = await messageResponse;
      final paymentResponse = NativePayment.processPayment(payment);
      paymentStatus.value = await paymentResponse ?? 'null';
    } catch (e) {
      log("message$e");

      throw Exception("not fill");
    }
  }
}
