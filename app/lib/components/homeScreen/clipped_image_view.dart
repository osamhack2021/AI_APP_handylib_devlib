import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:app/components/homeScreen/circular_clipper.dart';
import 'package:transparent_image/transparent_image.dart';

Widget ClippedImageView(BuildContext context, String _imageUrl) {
  return Stack(
    children: <Widget>[
      ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 6.0),
        child: Container(
          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          child: ClipShadowPath(
            clipper: CircularClipper(),
            shadow: const Shadow(blurRadius: 20.0),
            child: Opacity(
              opacity: 1,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _imageUrl,
                height: 400.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ), // Widget that is blurred
      ),
      Container(
        // padding: EdgeInsets.symmetric(horizontal: 100),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(110, 20, 110, 0),
        child: Center(
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
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _imageUrl,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
      Positioned(
        left: 20,
        top: 5,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(COLOR_PRIMARY).withOpacity(0.5),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    ],
  );
}
