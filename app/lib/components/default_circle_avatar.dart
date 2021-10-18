import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultCircleAvatar extends StatelessWidget {
  final double size;

  const DefaultCircleAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: (AssetImage(
          (kIsWeb ? "" : "assets/") + 'images/default_profile_image.png')),
      radius: size,
    );
  }
}
