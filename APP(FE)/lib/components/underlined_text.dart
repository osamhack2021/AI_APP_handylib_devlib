import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class UnderLinedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double thickness;
  final TextOverflow? overflow;
  const UnderLinedText(
      {Key? key,
      required this.text,
      this.style = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      this.overflow,
      required this.thickness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            text,
            style: style,
            overflow: overflow,
          ), // Text
        ), // Padding
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              margin: const EdgeInsets.only(right: 6),
              height: thickness,
              decoration: BoxDecoration(
                  color: Color(COLOR_PRIMARY).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10))), // Container
        ),
      ],
    );
  }
}
