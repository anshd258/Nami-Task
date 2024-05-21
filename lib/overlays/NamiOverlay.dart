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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    margin: EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade700, width: 1)),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 4),
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
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Icon(
                                        Icons.access_time_outlined,
                                        color: Colors.redAccent.shade700,
                                        size: 15,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
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
                        )
                      ],
                    ),
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
    );
  }
}
