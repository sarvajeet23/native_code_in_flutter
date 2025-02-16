package com.example.native_code_in_flutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast
import com.google.android.gms.location.Geofence
import com.google.android.gms.location.GeofencingEvent

class GeofenceReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent == null) return  // ✅ Check for null values

        val geofencingEvent = GeofencingEvent.fromIntent(intent)

        if (geofencingEvent?.hasError() == true) {  // ✅ Safe call (?.) for null safety
            Log.e("GEOFENCE", "Error: ${geofencingEvent.errorCode}")
            return
        }

        val geofenceTransition = geofencingEvent?.geofenceTransition ?: return  // ✅ Safe null check

        when (geofenceTransition) {
            Geofence.GEOFENCE_TRANSITION_ENTER -> {
                Toast.makeText(context, "Entered Geofence!", Toast.LENGTH_SHORT).show()
                Log.d("GEOFENCE", "Entered Geofence")
            }
            Geofence.GEOFENCE_TRANSITION_EXIT -> {
                Toast.makeText(context, "Exited Geofence!", Toast.LENGTH_SHORT).show()
                Log.d("GEOFENCE", "Exited Geofence")
            }
            else -> {
                Log.e("GEOFENCE", "Unknown transition")
            }
        }
    }
}
