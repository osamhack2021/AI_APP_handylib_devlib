import 'package:flutter/material.dart';

Widget EllipsisText(double _width, String _text, TextStyle _style) {
  return Container(
    width: _width,
    child: RichText(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: _style,
          text: _text,
        )),
  );
}
