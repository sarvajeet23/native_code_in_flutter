package com.example.native_code_in_flutter

import android.content.Context
import android.widget.Toast
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class Payment(private val context: Context, private val flutterEngine: FlutterEngine) {
    private val CHANNEL = "com.example/payment"

    fun setupMethodChannel() {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "processPayment") {
                val amount = call.argument<Double>("amount") ?: 0.0
                val response = processPayment(amount)
                result.success(response)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun processPayment(amount: Double): String {
        // Simulating a payment process
        Toast.makeText(context, "Processing payment of $$amount", Toast.LENGTH_SHORT).show()
        return "Payment of $$amount successful!"
    }
}
