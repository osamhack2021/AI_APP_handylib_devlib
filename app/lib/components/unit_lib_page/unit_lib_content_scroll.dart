import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:flutter/material.dart';

class UnitLibContentScroll extends StatelessWidget {
  final List<String> images;
  final String title;
  final double imageHeight;
  final double imageWidth;
  final String tag;

  UnitLibContentScroll({
    required this.images,
    required this.title,
    required this.imageHeight,
    required this.imageWidth,
    required this.tag
  });

  List<UnitBook>? unitBookList = getUnitBookList();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:EdgeInsets.all(1.0),
      child: Column(
        children: [
          ListTile(
            title:Text("$title"),
            trailing: 
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/home/unitlib/list'
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: imageHeight,
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return UnitBookDisplay(imageHeight: imageHeight, imageWidth: imageWidth);
              },
            ),
          ),
        ],
      ),
    );
  }
}

