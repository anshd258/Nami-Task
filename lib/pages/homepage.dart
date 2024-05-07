import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nami_app/pages/cannotverify.dart';
import 'package:nami_app/pages/selfiepage.dart';
import 'package:nami_app/widgets/capturebutton.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  static const homeScreenRoute = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(value: "Nami App"),
      ),
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: CaptureButton(
                title: "Task - 1 (Verified)",
                onClick: () {
                  Navigator.pushNamed(context, SelfieScreen.selfieScreenRoute);
                },
              ),
            ),
            Container(
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: CaptureButton(
                title: "Task - 1 (UnVerified)",
                onClick: () {
                  Navigator.pushNamed(context, CannotVerify.cannotVerify);
                },
              ),
            ),
            Container(
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: CaptureButton(
                title: "Task - 2",
                onClick: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
