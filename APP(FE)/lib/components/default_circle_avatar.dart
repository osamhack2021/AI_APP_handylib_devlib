import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final double size;

  const DefaultCircleAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: (AssetImage(
          'images/default_profile_image.png')),
      radius: size,
    );
  }
}
