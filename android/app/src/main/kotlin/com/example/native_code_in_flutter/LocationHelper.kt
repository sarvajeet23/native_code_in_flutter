package com.example.native_code_in_flutter

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.util.Log
import com.google.android.gms.location.*
import com.google.android.gms.tasks.Task

class LocationHelper(private val context: Context) {

    private val fusedLocationClient: FusedLocationProviderClient =
        LocationServices.getFusedLocationProviderClient(context)

    @SuppressLint("MissingPermission")
    fun getLocation(callback: (String) -> Unit) {
        try {
            val locationTask: Task<Location> = fusedLocationClient.lastLocation
            locationTask.addOnSuccessListener { location: Location? ->
                if (location != null) {
                    val locationString = "Lat: ${location.latitude}, Lng: ${location.longitude}"
                    callback(locationString)
                } else {
                    callback("LOCATION_ERROR")
                }
            }.addOnFailureListener { e ->
                Log.e("LocationHelper", "Error getting location", e)
                callback("LOCATION_ERROR: ${e.message}")
            }
        } catch (e: Exception) {
            Log.e("LocationHelper", "Exception: ${e.message}", e)
            callback("ERROR: ${e.message}")
        }
    }
}
