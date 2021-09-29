import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:app/components/homeScreen/circular_clipper.dart';

Widget ClippedImageView(BuildContext context, String _imageUrl) {
  return Stack(
    children: <Widget>[
      ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 6.0),
        child: Container(
          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          child: ClipShadowPath(
            clipper: CircularClipper(),
            shadow: Shadow(blurRadius: 20.0),
            child: Opacity(
                opacity: 0.83,
                child: Image(
                    height: 400.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage(_imageUrl),
                    colorBlendMode: BlendMode.modulate)),
          ),
        ), // Widget that is blurred
      ),
      Container(
          // padding: EdgeInsets.symmetric(horizontal: 100),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(110, 20, 110, 0),
          child: Center(
            child: Hero(
              tag: _imageUrl,
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Image(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(_imageUrl),
                      colorBlendMode: BlendMode.modulate)),
            ),
          )),
      IconButton(
        padding: EdgeInsets.only(left: 30.0),
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back),
        iconSize: 30.0,
        color: Colors.white,
      ),
    ],
  );
}
