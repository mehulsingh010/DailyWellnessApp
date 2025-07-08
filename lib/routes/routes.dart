import 'package:dailywellness_app/screens/dashboard.dart';
import 'package:dailywellness_app/screens/home.dart';
import 'package:dailywellness_app/screens/login.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
  };
}
