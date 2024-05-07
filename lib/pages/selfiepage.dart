import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nami_app/widgets/capturebutton.dart';
import 'package:nami_app/widgets/textbutton.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelfieScreen extends StatefulWidget {
  static const selfieScreenRoute = "/selfie";
  const SelfieScreen({Key? key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromRGBO(95, 105, 199, 1),
            )),
        elevation: 5,
        title: const TextWidget(value: "Face Verification"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/placeholder.png",
                width: 50.w,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                child: const TextWidget(
                  fontWeight: FontWeight.w700,
                  underLine: true,
                  value:
                      "Initiate face verification for quick attendance Process.",
                ),
              ),
              // Add some space between text and button
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: TextButtonWidget(onClick: () {}),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade700),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: CaptureButton(
          onClick: () {},
        ),
      ),
    );
  }
}
