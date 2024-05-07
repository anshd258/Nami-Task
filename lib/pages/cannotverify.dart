import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:nami_app/main.dart';
import 'package:nami_app/widgets/capturebutton.dart';
import 'package:nami_app/widgets/outlinedbutton.dart';
import 'package:nami_app/widgets/textbutton.dart';
import 'package:nami_app/widgets/textwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CannotVerify extends StatefulWidget {
  static const cannotVerify = "/cannotverify";
  const CannotVerify({Key? key}) : super(key: key);

  @override
  State<CannotVerify> createState() => _CannotVerifyState();
}

class _CannotVerifyState extends State<CannotVerify> {
  XFile? _picture;
  int reTakeCount = 0;
  bool takePicture = false;
  late CameraController _controller;
  bool unVerified = false;
  late Future<void> _initializeControllerFuture;
  double _progressValue = 0.0;
  int _seconds = 0;
  late Timer _timer;

  @override
  void initState() {
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    setState(() {
      unVerified = false;
      takePicture = true;
      _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          if (_seconds < 5) {
            _seconds++;
            _progressValue = (_seconds / 5);
            print(_progressValue);
          } else {
            capturePicture();
          }
        });
      });
    });
    reTakeCount++;
  }

  Future<void> capturePicture() async {
    var result = await _controller.takePicture();

    setState(() {
      _picture = result;
      takePicture = false;
      unVerified = true;
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
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
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              takePicture
                  ? CameraPreview(
                      _controller,
                      child: Stack(alignment: Alignment.center, children: [
                        Image.asset(
                          "assets/aligner.png",
                          width: 70.w,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: 1.h,
                          left: 5.w,
                          right: 5.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: TextWidget(
                                  value: "${_progressValue * 100}",
                                  fontSize: 12.dp,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              FAProgressBar(
                                animatedDuration:
                                    const Duration(milliseconds: 600),
                                borderRadius: BorderRadius.circular(30),
                                currentValue: _progressValue,
                                size: 2.h,
                                maxValue: 1,
                                progressGradient: LinearGradient(colors: [
                                  Color.fromRGBO(178, 185, 255, 1),
                                  Color.fromRGBO(95, 105, 199, 1)
                                ]),
                              ),
                            ],
                          ),
                        )
                      ]),
                    )
                  : _picture != null
                      ? Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_picture!.path),
                                width: 60.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Center(
                            child: Image.asset(
                              "assets/placeholder.png",
                              width: 60.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
              if (!takePicture) ...[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
                  child: Column(
                    children: [
                      TextWidget(
                        fontWeight: FontWeight.w700,
                        value: unVerified
                            ? "We couldnt recognize your face"
                            : "Initiate face verification for quick attendance Process.",
                      ),
                      if (reTakeCount > 1) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: TextWidget(
                            fontSize: 3.mm,
                            fontWeight: FontWeight.w400,
                            value:
                                "Don’t Worry, your request for Attendance has been sent to the Head for approval!",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: TextWidget(
                            fontSize: 3.mm,
                            fontWeight: FontWeight.w400,
                            value:
                                "Go to Dashboard and continue with your tasks for the day once your attendance is approved.",
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ]
              // Add some space between text and button
            ],
          ),
          if (!takePicture && !unVerified) ...[
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
          if (unVerified && reTakeCount <= 1) ...[
            Positioned(
              bottom: 17.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: RetakeButton(
                  onClick: () async {
                    await _takePicture();
                  },
                ),
              ),
            ),
          ]
        ],
      ),
      bottomNavigationBar: takePicture
          ? null
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.grey.shade700),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: CaptureButton(
                      title: unVerified
                          ? reTakeCount > 1
                              ? "Go to Dashboard"
                              : "Submit"
                          : "Verify",
                      enabled: unVerified
                          ? reTakeCount > 1
                              ? true
                              : false
                          : true,
                      onClick: () async {
                        await _takePicture();
                      },
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromRGBO(95, 105, 199, 1),
                  ));
                }
              },
            ),
    );
  }
}
