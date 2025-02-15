package com.example.native_code_in_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class NativeMessage(private val flutterEngine: FlutterEngine) {
    private val CHANNEL = "com.example/native"

    fun setupMethodChannel() {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getMessage") {
                result.success("Hello from Kotlin!")
            } else {
                result.notImplemented()
            }
        }
    }
}
