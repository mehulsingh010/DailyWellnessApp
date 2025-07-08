import 'package:dailywellness_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:dailywellness_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the initial screen to HomeScreen
      title: 'DailyWellness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: AppRoutes.routes, // Use the routes defined in AppRoutes
    );
  }
}
