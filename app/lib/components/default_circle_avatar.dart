
import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final size;

  const DefaultCircleAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: (
        AssetImage('default_profile_image.png')
      ),
      radius : size,
    );
  }
}