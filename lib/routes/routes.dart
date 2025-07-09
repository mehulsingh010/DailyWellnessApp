import 'package:dailywellness_app/screens/activity.dart';
import 'package:dailywellness_app/screens/dashboard.dart';
import 'package:dailywellness_app/screens/login.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String addActivity = '/add-activity';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
    addActivity: (context) => const AddActivityScreen(),
  };
}
