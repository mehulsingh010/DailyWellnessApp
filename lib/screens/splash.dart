import 'package:dailywellness_app/constants/colors.dart';
import 'package:dailywellness_app/routes/routes.dart';
import 'package:dailywellness_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(Duration(seconds: 2)); //splash delay

    String? email = await UserPreferences.getEmail();
    if (email != null && email.isNotEmpty) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or use a gradient background
      body: SafeArea(
        child: Stack(
          children: [
            // Center Logo & App Name
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.spa, size: 100, color: tdBlue),
                  // Blue shade
                  SizedBox(height: 20),
                  Text(
                    "DailyWellness",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: tdBlue,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircularProgressIndicator(color: tdBlue),
                ],
              ),
            ),
            // Bottom Text
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Created by Mehul Charak",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
