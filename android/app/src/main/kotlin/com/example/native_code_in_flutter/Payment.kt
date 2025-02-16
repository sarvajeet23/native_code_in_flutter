package com.example.native_code_in_flutter

import android.content.Context
import android.widget.Toast

class Payment(private val context: Context) {
    fun processPayment(amount: Double): String {
        // Toast.makeText(context, "Processing payment of $$amount", Toast.LENGTH_SHORT).show()
        return "%.2f".format(amount)
    }
}
