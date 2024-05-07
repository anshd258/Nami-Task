import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CaptureButton extends StatelessWidget {
  final Function onClick;
  const CaptureButton({Key? key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onClick.call();
        },
        style: ElevatedButton.styleFrom(
            maximumSize: Size(100.w, 100.h),
            minimumSize: Size(15.w, 5.h),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.w),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color.fromRGBO(95, 105, 199, 1)),
        child: const TextWidget(
          value: "Verify",
          color: Colors.white,
        ));
  }
}
