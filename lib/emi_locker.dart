import 'package:flutter/material.dart';

import 'device_control.dart';
import 'lock_screen.dart';

class EmiLocker extends StatefulWidget {
  const EmiLocker({super.key});

  @override
  State<EmiLocker> createState() => _EmiLockerState();
}

class _EmiLockerState extends State<EmiLocker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(title: Text("Emi Locker")),
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
              ),
              onPressed: () {
                DeviceControl.lockDevice();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LockScreen()),
                );
              },
              child: Text("Lock Device", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
