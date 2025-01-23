import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'reusable_layout.dart';

class CallLogAccessScreen extends StatelessWidget {
  const CallLogAccessScreen({super.key});

  Future<void> requestCallLogPermission(BuildContext context) async {
    PermissionStatus status = await Permission.phone.request();

    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Call log permission granted!'),
        ),
      );
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Call log permission denied!'),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableLayout(
      currentIndexTop: 0,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -0.1, // Slight rotation for the mockup
                child: Image.asset(
                  'assets/mockup.png',
                  width: 250, // Adjust size to match the design
                ),
              ),
              Positioned(
                top: 100,
                child: Image.asset(
                  'assets/approved.png',
                  width: 100, // Adjust the size of the approved icon
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "Access Your Call Logs",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "We need access to your contacts and call logs to help you connect and manage your communication seamlessly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 40),
          MaterialButton(
            onPressed: () {
              requestCallLogPermission(context);
            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: const Text(
              "Allow Access",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      indexBottom: 0,
    );
  }
}
