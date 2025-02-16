import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_code_in_flutter/controller/location_controller.dart';
import '../controller/native_controller.dart';

class HomePage extends StatelessWidget {
  final NativeController controller = Get.put(NativeController());
  final LocationController locationController = Get.put(LocationController());

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native Calls")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 8,
            children: [
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  label: Text("message"),
                  border: OutlineInputBorder(),
                ),
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: _paymentController,
                decoration: InputDecoration(
                  label: Text("payment"),
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed:
                    () => controller.submit(
                      _messageController.text,
                      double.tryParse(_paymentController.text) ?? 0.0,
                    ),
                child: Text("Submit"),
              ),

              Obx(
                () => Text(
                  controller.messages.value,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),

              Divider(),
              Obx(
                () => Text(
                  controller.paymentStatus.value,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => locationController.fetchLocation(),
                child: Text("Get Location"),
              ),

              Obx(() => Text(locationController.currentLocation.value)),

              ElevatedButton(
                onPressed:
                    () => locationController.addGeofence(37.7749, -122.4194),
                child: Text("Add Geofence"),
              ),

              Obx(() => Text(locationController.geofenceStatus.value)),
            ],
          ),
        ),
      ),
    );
  }
}
