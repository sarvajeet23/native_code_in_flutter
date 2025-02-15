package com.example.native_code_in_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize multiple channels
        val nativeMessage = NativeMessage(flutterEngine)
        nativeMessage.setupMethodChannel()

        val payment = Payment(this, flutterEngine)
        payment.setupMethodChannel()
    }
}
