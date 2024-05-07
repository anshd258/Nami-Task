import 'package:flutter/material.dart';
import 'package:nami_app/pages/cannotverify.dart';
import 'package:nami_app/pages/homepage.dart';
import 'package:nami_app/pages/selfiepage.dart';

    //* app router having route to all app pages
class AppRouterHandler {
  //? stattic class bind method for app routing 
  static Route<dynamic>? appRoute(settings) {
    switch (settings.name) {
      case HomeScreen.homeScreenRoute:     //! home screen 
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SelfieScreen.selfieScreenRoute: //! verified selfie
        return MaterialPageRoute(
          builder: (context) => const SelfieScreen(),
        );
      case CannotVerify.cannotVerify:     //! unverified selfie
        return MaterialPageRoute(
          builder: (context) => const CannotVerify(),
        );
      default:                            //! default router
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
