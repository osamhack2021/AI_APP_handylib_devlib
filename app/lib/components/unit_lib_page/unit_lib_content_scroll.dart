import 'package:app/components/error_notifier.dart';
import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/pages/unit_lib_book_list_page.dart';
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
      return await getUnitBookList(myUser!.unit, 1);
      /*for (int i = 1; i < 10; i++) {
        debugPrint(unitBookList![i].title);
        debugPrint(unitBookList![i].coverUrl);
      }*/
    } else if (widget.tag == 'best' || widget.tag == 'new') {
      return await getUnitTagBookList(myUser!.unit, widget.tag);
    } else if (widget.tag == 'borrow') {
      return await getBorrowBookList(myUser!.unit);
    } else {
      debugPrint('unitbooklist의 태그가 잘못되었습니다 : unit_lib_content_scroll');
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
            trailing: FutureBuilder<List<UnitBook>>(
                future: _getUnitBooksList(),
                builder: (BuildContext context, unitBookList) {
                  bool useable = false;
                  if (unitBookList.hasData) {
                    useable = true;
                  } else if (unitBookList.hasError) {
                    //unable
                    useable = false;
                  } else
                    useable = false;
                  return IconButton(
                    onPressed: () {
                      if (useable) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UnitLibBookListPage(
                                unitBookList: unitBookList.data,
                                tag: widget.tag),
                          ),
                        );
                      } else
                        null;
                    },
                    icon: Icon(Icons.arrow_forward),
                  );
                }),
          ),

          /*IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                      UnitLibBookListPage(unitBookList: unitBookList, tag : widget.tag),
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),*/
          SizedBox(
              height: 200,
              child: FutureBuilder<List<UnitBook>>(
                  future: _getUnitBooksList(),
                  builder: (BuildContext context, unitBookList) {
                    List<Widget> children;
                    if (unitBookList.hasData) {
                      return ListView(
                        padding: EdgeInsets.all(8.0),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (UnitBook _thisUnitBook in unitBookList.data!)
                            UnitBookDisplay(
                                bookData: _thisUnitBook,
                                imageHeight: bookImageHeightConst,
                                imageWidth: bookImageWidthConst),
                        ],
                      );
                    } else if (unitBookList.hasError) {
                      children = <Widget>[
                        if (widget.tag == 'borrow')
                          ErrorNotifier(errorMessage: '아직 대출한 책이 없어요.')
                        else
                          ErrorNotifier(errorMessage: '우리 부대는 아직 책이 등록되지 않았어요.')
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
