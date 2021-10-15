import 'package:app/components/error_notifier.dart';
import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatelessWidget {
  final List<UnitBook>? unitBookList;
  final String? tag;

  UnitLibBookListPage({this.unitBookList, this.tag});

  final _key = GlobalKey();

  @override

  void _getSize() {   
    final _size = _key.currentContext!.size;
    final _width = _size!.width; 
    final _height = _size.height;
  } 

  Widget build(BuildContext context) {
    if (unitBookList == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '책 리스트를 불러오지 못했어요.',
        ),
      );
    }

    debugPrint(unitBookList.toString());
    debugPrint(tag);
    return Scaffold(
      appBar: AppBar(
        title: Text("${getUnitBookClassTitlebyTag(tag!)} 목록"),
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisCount: 3,
                  children: <Widget>[
                    for (UnitBook _curUnitBook in unitBookList!)
                      UnitBookDisplay(
                          bookData: _curUnitBook,
                          imageHeight: null,
                          imageWidth: null),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }
}
