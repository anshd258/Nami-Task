import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'package:nami_app/widgets/textwidget.dart';

class NamiOverlay extends StatefulWidget {
  const NamiOverlay({Key? key}) : super(key: key);

  @override
  State<NamiOverlay> createState() => _NamiOverlayState();
}

class _NamiOverlayState extends State<NamiOverlay> {
  static const String _kPortNameOverlay = 'OVERLAY'; // !isolate overlay name
  static const String _kPortNameHome = 'UI'; // !isolate home name
  bool _loading = false; //! for loading screen
  final _receivePort = ReceivePort(); //!reciever port for overlay to recieve mesasages for overlay

  SendPort? homePort; //! send port overlay to send messages to the overlay
  bool? messageFromOverlay;

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName( //! registering the isolate of overlay
      _receivePort.sendPort,
      _kPortNameOverlay,
    );
    print("$res : HOME");
    _receivePort.listen((message) { //! listeming to messages comiing from ui main thread
      print("message from UI: $message");
      setState(() {
        messageFromOverlay = bool.parse(message.toString());
        print(messageFromOverlay);
        setState(() {
          if (messageFromOverlay != null) {
            print(messageFromOverlay);
            _loading = !(messageFromOverlay!);
           
          }
        });
         Future.delayed(
              Duration(milliseconds: 500),
              () async => await FlutterOverlayWindow.closeOverlay(), //! closing ovelay
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Colors.black38,
                  spreadRadius: 1,
                  offset: Offset(1, 1))
            ], borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/rafiki.png",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextWidget(
                          value: "Reminder",
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextWidget(
                        value: "This Request needs to be completed soon",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade700.withOpacity(0.5),
                                width: 0.5)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.food_bank_rounded,
                                      color: Colors.indigoAccent.shade400,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: TextWidget(
                                        value: "Rajesh",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 13,
                                      color: Colors.redAccent.shade400,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 4),
                                      child: TextWidget(
                                        value: "Not Accepted",
                                        fontSize: 12,
                                        color: Colors.redAccent.shade200,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.repeat_on_rounded,
                                        size: 18,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                                Chip(
                                    visualDensity: VisualDensity.compact,
                                    shape: StadiumBorder(),
                                    side: BorderSide.none,
                                    backgroundColor: Colors.red.shade100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 1),
                                    label: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3),
                                          child: Icon(
                                            Icons.access_time_outlined,
                                            color: Colors.redAccent.shade700,
                                            size: 15,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3),
                                          child: TextWidget(
                                            value: "1 min",
                                            fontSize: 12,
                                            color: Colors.redAccent.shade700,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  value: 'Routine Cleaning',
                                  color: Color(0xFF1A0A02),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                Chip(
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  labelPadding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  shape: StadiumBorder(),
                                  side: BorderSide.none,
                                  backgroundColor:
                                      Color(0xFF5E69C6).withOpacity(0.2),
                                  label: TextWidget(
                                    value: 'Internal Task',
                                    color: Color(0xFF5E69C6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        color: Color(0xFF767676),
                                        size: 17,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextWidget(
                                          value: ' 21 Jul 2024 | 03:00 am',
                                          color: Color(0xFF767676),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                    value: '# 68988',
                                    color: Color(0xFF767676),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextWidget(
                                      value: 'From:Pantry',
                                      color: Color(0xFF767676),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextWidget(
                                    value: 'To:Reception',
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: OutlinedButton(
                                onPressed: () async {
                                  await FlutterOverlayWindow.closeOverlay();
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color:
                                          const Color.fromRGBO(95, 105, 199, 1),
                                      width: 1),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: TextWidget(
                                  value: "Dismiss",
                                  fontSize: 16,
                                  color: const Color.fromRGBO(95, 105, 199, 1),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _loading = true;
                                    });
                                    homePort ??=
                                        IsolateNameServer.lookupPortByName(
                                            _kPortNameHome);
                                    homePort?.send(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: const Color.fromRGBO(
                                          95, 105, 199, 1)),
                                  child: TextWidget(
                                    value: "Notify Staff",
                                    fontSize: 16,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () async {
                            await FlutterOverlayWindow.closeOverlay();
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.redAccent.shade400,
                          )))
                ],
              ),
            ),
          ),
          if (_loading) ...[
            Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.withOpacity(0.2)),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ]
        ],
      ),
    );
  }
}
