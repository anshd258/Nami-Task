import 'package:flutter/material.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

    //* basic elevated button to use in app (used in verify , submit and others)
class CaptureButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final bool enabled; //? used for enabliing disabling the elevated button
  const CaptureButton({Key? key, required this.onClick, this.enabled = true, required this.title});

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
            backgroundColor: enabled
                ? const Color.fromRGBO(95, 105, 199, 1)
                : const Color.fromRGBO(191, 191, 191, 1)),
        child:  TextWidget(
          value: title,
          color: Colors.white,
        ));
  }
}
