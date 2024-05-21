import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:nami_app/widgets/textwidget.dart';

class ConfirmationOverlay extends StatefulWidget {
  const ConfirmationOverlay({ Key? key }) : super(key: key);

  @override
  State<ConfirmationOverlay> createState() => _ConfirmationOverlayState();
}

class _ConfirmationOverlayState extends State<ConfirmationOverlay> {
 

  @override
  void initState() {
    super.initState();
     Future.delayed(
              Duration(seconds: 1),
              () async => await FlutterOverlayWindow.closeOverlay(),
            );
    
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
                          value: "Notified the staff",
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextWidget(
                        value: "we have notified your staff to take quick action for this task",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                     
                      
                    ],
                  ),
                 
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}