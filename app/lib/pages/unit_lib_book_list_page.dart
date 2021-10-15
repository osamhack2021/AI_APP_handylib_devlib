import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatelessWidget {
  final List<UnitBook>? unitBookList;
  final String? tag;

  const UnitLibBookListPage({this.unitBookList,this.tag});
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("${getUnitBookClassTitlebyTag(tag!)} 목록"),
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: ( 
            SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 3
            )
          ),
          children : <Widget>[
            for(UnitBook _curUnitBook in unitBookList!) 
              UnitBookDisplay(
                bookData: _curUnitBook,
                imageHeight: bookImageHeightConst,
                imageWidth: bookImageWidthConst),
            ],

        )
      ),
      //ListView(children: <Widget>[
      /*GridView.builder(
          primary:true,
          gridDelegate: ( 
            SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 3
            )
          ),
          itemCount: 10,
          itemBuilder: (
            (BuildContext context, int index) {
              return Card(
          color: Colors.amber,
          child: Center(child: Text('$index')),
        );
            }
          ),
        ),*/
      // ],
      // ),
    );
  }
}
