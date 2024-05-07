import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:nami_app/main.dart';
import 'package:nami_app/widgets/appbar.dart';
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
  XFile? _picture; //? to store the picture

  int reTakeCount =
      0; //? to count the no of times user have retaken the verification step

  bool takePicture =
      false; //? boolen for functionality to display and hide the live preview and other func.

  late CameraController _controller; //? camera controller

  bool unVerified = false; //? boolen to mark the picture has been taken
  //                         ? I could have used the _picture to cheeck that also but a seprate booling is better for understanding

  late Future<void>
      _initializeControllerFuture; //? future to get if cameera is initalized or not

  double _progressValue =
      0.0; //? progress value to mimic ai face detection (can also be done using google ml)

  int _seconds = 0; //? seconds counter

  late Timer _timer; //? late timer for progress bar

  //! init state here only gets the camers description and initializes the camera
  //! and gets the initalization completion
  @override
  void initState() {
    //* camera description getting
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    //* setting camera
    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    //* setting Future of function in variable to use it later in Futurebuilder
    _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel(); //? disposing timer
    _controller.dispose(); //? disposing camera controller
    super.dispose();
  }

  //* function to handle timer and progress value
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
            //! this function handles the picture taking func.
            capturePicture();
          }
        });
      });
    });
    reTakeCount++;
  }

  //! picture  taking func.
  Future<void> capturePicture() async {
    //? simpley takes the picture
    var result = await _controller.takePicture();
    //? updates the app state
    setState(() {
      _picture = result;
      takePicture = false;
      unVerified = true;
      _seconds = 0;
      _timer.cancel(); //! cancels the timer as its a peeriodic timer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: namiAppBar(context),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              takePicture //? checks if user has clicked on verify button or not if yes then

                  ? CameraPreview(
                      //? show the camera preview with
                      _controller,
                      child: Stack(alignment: Alignment.center, children: [
                        //? a place holder face aligne
                        Image.asset(
                          "assets/aligner.png",
                          width: 70.w,
                          fit: BoxFit.contain,
                        ),
                        //? and a bottom progress bar
                        Positioned(
                          bottom: 1.h,
                          left: 5.w,
                          right: 5.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //? pogress in %
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: TextWidget(
                                  value: "${_progressValue * 100} %",
                                  fontSize: 5.mm,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              //? animated progress bar
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
                  : _picture !=
                          null //! now if _picture is taken then display the picture
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
                          //? else if nor photo is getting taken or is taken then show the place holder
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
                //? how the message when picture is not being taken
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
                  child: Column(
                    children: [
                      TextWidget(
                        fontWeight: FontWeight.w700,
                        value: unVerified //? if photo is taken
                            ? "We couldnt recognize your face" //? then this message
                            : "Initiate face verification for quick attendance Process.", //? else this
                      ),
                      if (reTakeCount > 1) ...[
                        //? if the user have tried multiple timer to take picture then show
                        //? show the message and route them to home
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
            //? show privacy policy only beforee taking the picture
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child:
                    TextButtonWidget(title: "Privacy Policy", onClick: () {}),
              ),
            ),
          ],
          if (unVerified && reTakeCount <= 1) ...[
            //? retake only after he has taken a picture
            Positioned(
              bottom: 17.h,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: RetakeButton(
                  title: "Re-Take",
                  onClick: () async {
                    await _takePicture();
                  },
                ),
              ),
            ),
          ]
        ],
      ),
      //* bottom nav bar starting used for verify , submit button
      bottomNavigationBar:
          takePicture //! if user ia aking picture then hide the bottom elevated button else show it
              ? null
              : FutureBuilder<void>(
                  //? future builder too show button only afteer cameras has been initalized
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                                width: 1, color: Colors.grey.shade700),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: CaptureButton(
                          title: unVerified
                              ? reTakeCount > 1
                                  ? "Go to Dashboard" //? if photo has been taken and more then once
                                  : "Submit" //? if photo has been taken once
                              : "Verify", //? if not photo has been taken

                          //? enable and disable button as as the logic above
                          enabled: unVerified
                              ? reTakeCount > 1
                                  ? true
                                  : false
                              : true,
                          onClick: () async {
                            if (unVerified) {
                              //? if verified and has taken picture more then once
                              if (reTakeCount > 1) {
                                Navigator.pop(
                                    context); //? then route them to home page on click of button
                              }
                            } else {
                              await _takePicture(); //? if if not photo has been taken take picture
                            }
                          },
                        ),
                      );
                    } else {
                      //? loading while camers are initallizing
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
