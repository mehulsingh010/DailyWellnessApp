import 'package:dailywellness_app/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:dailywellness_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TaskProvider())],
      child: MaterialApp(
        // Set the initial screen to HomeScreen
        title: 'DailyWellness',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute:
            AppRoutes.initial, // Use the initial route defined in AppRoutes
        routes: AppRoutes.routes, // Use the routes defined in AppRoutes
      ),
    );
  }
}
