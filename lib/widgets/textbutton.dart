import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';

    //* simple text button to use in the app (used it in privacy policy btton)
class TextButtonWidget extends StatelessWidget {
  final Function onClick;
  final String title;
  const TextButtonWidget({Key? key, required this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {

    //! used gesture detector becuase a native splaash is there in text button
    return GestureDetector(
        onTap: () {
          onClick.call();
        },
        child:  TextWidget(
          underLine: true,
          value: title,
          color: const Color.fromRGBO(95, 105, 199, 1),
        ));
  }
}
