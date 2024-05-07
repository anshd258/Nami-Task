import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nami_app/core/approute.dart';
import 'package:nami_app/pages/homepage.dart';
import 'package:nami_app/theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();  

    //? Initalizing Available Cameras
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return MaterialApp(
          theme: customTheme, 
          initialRoute: HomeScreen.homeScreenRoute,
          //? Seprate Routes Table for Code Structuring
          onGenerateRoute: (settings) => AppRouterHandler.appRoute(settings),
        );
      },
    );
  }
}
