import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UnitLibContentScroll extends StatefulWidget {
  final String tag;

  UnitLibContentScroll({required this.tag});

  @override
  State<UnitLibContentScroll> createState() => _UnitLibContentScrollState();
}

class _UnitLibContentScrollState extends State<UnitLibContentScroll> {
  List<UnitBook>? unitBookList;

  Future getTotalList() async {
    if (widget.tag == 'total') {
      debugPrint('total list loading start');
      unitBookList = await getUnitBookList(myUser!.unit);
      debugPrint('total list loaded');
      for (int i = 1; i < 10; i++) {
        debugPrint(unitBookList![i].title);
      }
    } else {
      unitBookList = getUnitBookList_test();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    getTotalList();
    debugPrint(widget.tag);
    debugPrint('$unitBookList');
    debugPrint(unitBookList![4].title);


    return Card(
      margin: EdgeInsets.all(1.0),
      child: Column(
        children: [
          ListTile(
            title: Text("${getUnitBookClassTitlebyTag(widget.tag)}"),
            trailing: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/home/unitlib/list', arguments: widget.tag);
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return UnitBookDisplay(
                    bookData: unitBookList![index],
                    imageHeight: bookImageHeightConst,
                    imageWidth: bookImageWidthConst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
