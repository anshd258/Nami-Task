import 'package:flutter/material.dart';
import 'package:nami_app/core/approute.dart';
import 'package:nami_app/pages/homepage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          initialRoute: HomeScreen.homeScreenRoute,
          onGenerateRoute: (settings) => AppRouterHandler.appRoute(settings),
        );
      },
    );
  }
}
