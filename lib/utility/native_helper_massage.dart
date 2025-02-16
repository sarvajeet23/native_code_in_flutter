import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NativeHelperMassage extends GetxService {
  static const MethodChannel _methodChannel = MethodChannel(
    "com.example/native",
  );

  static Future<String> getNativeMessage(String message) async {
    try {
      final String response = await _methodChannel.invokeMethod("getMessage", {
        "message": message,
      });
      log("result::$response");
      return response;
    } on PlatformException catch (e) {
      return "Failed to get message: '${e.message}'";
    }
  }
}
