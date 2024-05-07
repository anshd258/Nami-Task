import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RetakeButton extends StatelessWidget {
  final Function onClick;
  const RetakeButton({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          onClick.call();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: const Color.fromRGBO(95, 105, 199, 1), width: 1),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: const Icon(
                Icons.refresh_rounded,
                color: Color.fromRGBO(95, 105, 199, 1),
              ),
            ),
            const TextWidget(
              value: "Re-Take",
              color: Color.fromRGBO(95, 105, 199, 1),
            ),
          ],
        ));
  }
}
