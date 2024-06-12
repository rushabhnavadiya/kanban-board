import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/pages/dashboard.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // Dashboard page
      case '/dashboard':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const Dashboard(),
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}