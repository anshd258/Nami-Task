import 'package:flutter/material.dart';
import 'package:nami_app/pages/cannotverify.dart';
import 'package:nami_app/pages/homepage.dart';
import 'package:nami_app/pages/selfiepage.dart';

class AppRouterHandler {
  static Route<dynamic>? appRoute(settings) {
    switch (settings.name) {
      case HomeScreen.homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SelfieScreen.selfieScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SelfieScreen(),
        );
      case CannotVerify.cannotVerify:
        return MaterialPageRoute(
          builder: (context) => const CannotVerify(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
