import 'dart:isolate';
import 'dart:ui';

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
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  bool? latestMessageFromOverlay;

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    print("$res: OVERLAY");
    _receivePort.listen((message) {
      print("message from OVERLAY: $message");
      setState(() {
        latestMessageFromOverlay = bool.parse(message.toString());
        if (latestMessageFromOverlay != null && latestMessageFromOverlay!) {
          SendPort? overlayport =
              IsolateNameServer.lookupPortByName(_kPortNameOverlay);
          if (overlayport != null) {
            Future.delayed(
              const Duration(seconds: 2),
              () => overlayport.send(true),
            );
          }
        }
      });
    });
  }

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
            //! button for calling the overlay
            Container(
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: CaptureButton(
                title: "Task - 2 (Overlay)",
                onClick: () async {
                  if (await FlutterOverlayWindow.isActive())
                    return; //?checking if overlay is already active or not
                  await FlutterOverlayWindow.showOverlay(
                    //* calling the overlay
                    enableDrag: true,
                    overlayTitle: "Nami Ovverlay",
                    overlayContent: 'Overlay Enabled',
                    flag: OverlayFlag.defaultFlag,
                    visibility: NotificationVisibility.visibilityPublic,
                    positionGravity: PositionGravity.auto,
                    startPosition: const OverlayPosition(0.5, 0.5),
                    height: (MediaQuery.of(context).size.height * 3).toInt(),
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
