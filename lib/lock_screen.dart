import 'package:flutter/material.dart';

import 'device_control.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Device Locked",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),

            SizedBox(height: 20),

            Text(
              "Please pay EMI to unlock device",
              style: TextStyle(color: Colors.white),
            ),

            ElevatedButton(
              onPressed: () {
                DeviceControl.unlockDevice();
                Navigator.pop(context);
              },
              child: Text("Unlock Device"),
            ),
          ],
        ),
      ),
    );
  }
}
