import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/native_controller.dart';

class HomePage extends StatelessWidget {
  final NativeController controller = Get.put(NativeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Native Calls")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                controller.message.value,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.getMessage,
              child: Text("Message"),
            ),
            Divider(),
            Obx(
              () => Text(
                controller.paymentStatus.value,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.processPayment(200.0),
              child: Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
