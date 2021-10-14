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

  Future<List<UnitBook>> _getUnitBooksList() async {
    if (widget.tag == 'total') {
      return await getUnitBookList(myUser!.unit);
      /*for (int i = 1; i < 10; i++) {
        debugPrint(unitBookList![i].title);
        debugPrint(unitBookList![i].coverUrl);
      }*/
    } else if (widget.tag == 'best' || widget.tag == 'new') {
      return await getUnitTagBookList(myUser!.unit, widget.tag);
    } else {
      return getUnitBookList_test();
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUnitBooksList();

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
              child: FutureBuilder<List<UnitBook>>(
                  future: _getUnitBooksList(),
                  builder: (BuildContext context, unitBookList) {
                    List<Widget> children;
                    if (unitBookList.hasData) {
                      children = <Widget>[
                        for (UnitBook _thisUnitBook in unitBookList.data!)
                          UnitBookDisplay(
                              bookData: _thisUnitBook,
                              imageHeight: bookImageHeightConst,
                              imageWidth: bookImageWidthConst),
                      ];
                    } else if (unitBookList.hasError) {
                      children = <Widget>[
                        Text('오류로 인하여 책 목록을 로드하지 못했습니다.'),
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('로딩 중입니다...'),
                        )
                      ];
                    }
                    return ListView(
                      padding: EdgeInsets.all(8.0),
                      scrollDirection: Axis.horizontal,
                      children: children,
                    );
                  })

              /*
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return UnitBookDisplay(
                    bookData: (unitBookList==null)? defaultUnitBookModel(): unitBookList![index],
                    imageHeight: bookImageHeightConst,
                    imageWidth: bookImageWidthConst);
              },
            ),*/
              ),
        ],
      ),
    );
  }
}
