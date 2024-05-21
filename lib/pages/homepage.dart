import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:nami_app/pages/cannotverify.dart';
import 'package:nami_app/pages/selfiepage.dart';
import 'package:nami_app/widgets/capturebutton.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

//* home page of the app
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
            //! for going to the verified selfie page
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

            //! for going to the unveerified selfie page
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
                title: "Task - 2 (Overlay)",
                onClick: () async {
                  if (await FlutterOverlayWindow.isActive()) return;
                  await FlutterOverlayWindow.showOverlay(
                    enableDrag: true,
                    overlayTitle: "Nami Ovverlay",
                    overlayContent: 'Overlay Enabled',
                    flag: OverlayFlag.defaultFlag,
                    visibility: NotificationVisibility.visibilityPublic,
                    positionGravity: PositionGravity.auto,
                    startPosition: OverlayPosition(0.5, 0.5),
                    height: (MediaQuery.of(context).size.height * 2.8).toInt(),
                    width: (MediaQuery.of(context).size.width * 3.5).toInt(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
