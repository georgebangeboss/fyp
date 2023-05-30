import 'package:flutter/material.dart';
import 'package:fyp/main.dart';
import 'package:fyp/splash.dart';

class RouteManager {
  static const String splash = "/";
  static const String home = "/dashboard";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => Splash());
      case home:
        return MaterialPageRoute(
            builder: (context) => MyHomePage(
                  ipAddressPort: args as String,
                ));

      default:
        throw FormatException("Route does not exist");
    }
  }
}
