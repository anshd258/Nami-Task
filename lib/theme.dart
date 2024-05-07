import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  scaffoldBackgroundColor:
      Colors.white, //!to set global scaffold bg color to white
  appBarTheme: const AppBarTheme(
      color: Colors.white,
      surfaceTintColor: Colors
          .white //!to set global app bar bg color and surfacce tint to white
      ),
);
