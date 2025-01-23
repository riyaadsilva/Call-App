import 'package:flutter/material.dart';

class DialPadScreen extends StatefulWidget {
  const DialPadScreen({super.key});

  @override
  State<DialPadScreen> createState() => _DialPadScreenState();
}

class _DialPadScreenState extends State<DialPadScreen> {
  String phoneNumber = "";

  void _appendNumber(String number) {
    setState(() {
      phoneNumber += number;
    });
  }

  void _deleteLastDigit() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Dialpad",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display phone number
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Dialpad buttons
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.3, // Adjust aspect ratio for tighter circles
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index == 9) {
                return const SizedBox(); // Empty space for layout consistency
              } else if (index == 11) {
                return IconButton(
                  onPressed: _deleteLastDigit,
                  icon: const Icon(Icons.backspace),
                  color: Colors.grey,
                );
              } else {
                final number = index == 10 ? "0" : (index + 1).toString();
                return Padding(
        padding: const EdgeInsets.all(8.0), // Space around each button
        child: ElevatedButton(
          onPressed: () => _appendNumber(number),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10), // Reduced padding inside the circle
            backgroundColor: Colors.white, // White background
            elevation: 0.1, // Slight elevation
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 20, // Adjust font size to match smaller circle
              fontWeight: FontWeight.bold,
              color: Color(0xFF5864F8), // Blue text color
            ),
          ),
        ),
      );
              }
            },
          ),
          const SizedBox(height: 20),
          // Call button
          ElevatedButton(
            onPressed: () {
              // Perform action for the call button
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5864F8),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(18), // Slightly smaller call button
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
