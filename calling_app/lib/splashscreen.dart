import 'package:calling_app/recent_call_logs.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'accesscallog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _logoVisible = false;

  @override
  void initState() {
    super.initState();

    // Scale animation for the faint circle
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation and set logo visibility
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoVisible = true;
      });
    });

    // Navigate to the next screen after 3 seconds
    Future.delayed(const Duration(seconds: 1), () async {
      PermissionStatus status = await Permission.phone.request();

      if (status.isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecentCallsScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CallLogAccessScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF0F4FF), // Light blue
              Color(0xFFFFFFFF), // White
            ],
          ),
        ),
        child: Stack(
          children: [
            // Faint blue circle animation behind the logo
            Center(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB3D4FC), // Faint powder blue
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Logo and tagline
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _logoVisible ? 1.0 : 0.0,
                    duration: const Duration(seconds: 1),
                    child: Image.asset(
                      'assets/surefylogo.png',
                      width: 180,
                    ),
                  ),
                ],
              ),
            ),
            // Phone outline at the bottom
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Icon(Icons.smartphone_rounded,
                    size: 40, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
