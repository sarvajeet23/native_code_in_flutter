import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NativeHelperMassage extends GetxService {
  static const MethodChannel _methodChannel = MethodChannel(
    "com.example/native",
  );

  static Future<String> getNativeMessage() async {
    try {
      final String result = await _methodChannel.invokeMethod("getMessage");
      log("result::$result");
      return result;
    } on PlatformException catch (e) {
      return "Failed to get message: '${e.message}'";
    }
  }
}
