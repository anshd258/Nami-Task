 import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';

    //* global app  bar
AppBar namiAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color.fromRGBO(95, 105, 199, 1),
          )),
      elevation: 5,
      title: const TextWidget(value: "Face Verification"),
    );
  }
