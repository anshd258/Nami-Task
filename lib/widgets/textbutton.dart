import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';

class TextButtonWidget extends StatelessWidget {
  final Function onClick;
  const TextButtonWidget({Key? key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onClick.call();
        },
        child: const TextWidget(
          underLine: true,
          value: "Privacy Notice",
          color: Color.fromRGBO(95, 105, 199, 1),
        ));
  }
}
