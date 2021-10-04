
import 'package:flutter/material.dart';

class UnitBookDisplay extends StatelessWidget {
  const UnitBookDisplay({
    Key? key,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('you clicked');
        Navigator.of(context).pushNamed(
          '/home/unitlib/book-detail',
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
        height:imageHeight,
        width: imageWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 4.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: AssetImage('images/default_book_cover_image.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}