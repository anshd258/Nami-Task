import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

    //* used to make a global text widget with font sans expanded with configrations 
class TextWidget extends StatelessWidget {
  final FontWeight? fontWeight;
  final Color? color;
  final bool underLine; //? used for underlining the button
  final String value;
  const TextWidget(
      {super.key,
      this.fontSize,
      this.underLine = false,
      this.fontWeight,
      this.color,
      required this.value});
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: TextAlign.center,
      style: GoogleFonts.encodeSansExpanded(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: underLine ? TextDecoration.underline : null),
    );
  }
}
