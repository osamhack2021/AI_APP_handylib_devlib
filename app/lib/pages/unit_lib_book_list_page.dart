import 'package:app/components/error_notifier.dart';
import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatefulWidget {
  List<UnitBook>? unitBookList;
  final String? tag;

  UnitLibBookListPage({this.unitBookList, this.tag});

  @override

  State<UnitLibBookListPage> createState() => _UnitLibBookListPageState();
}

class _UnitLibBookListPageState extends State<UnitLibBookListPage> {
  int page = 1;

  Future<List<UnitBook>> _getUnitBooksList(int page) async {
    if (widget.tag == 'total') {
      return await getUnitBookList(myUser!.unit, page);
    } else if (widget.tag == 'best' || widget.tag == 'new') {
      return await getUnitTagBookList(myUser!.unit, widget.tag!);
    } else if (widget.tag == 'borrow') {
      return await getBorrowBookList(myUser!.unit);
    } else {
      debugPrint('unitbooklist의 태그가 잘못되었습니다 : unit_lib_content_scroll');
      return getUnitBookList_test();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.unitBookList == null || widget.tag == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '책 리스트를 불러오지 못했어요.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${getUnitBookClassTitlebyTag(widget.tag!)} 목록"),
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UnitBook>> (
        future: _getUnitBooksList(page),
        builder:(BuildContext context, unitBookList) {
          List<Widget> children;
          if(unitBookList.hasData) {
            return CustomScrollView(
              primary: false,
              slivers: <Widget>[
                SliverPadding(
//                   padding: const EdgeInsets.all(0),
//                   sliver: SliverGrid.count(
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                     children: <Widget>[
//                       for (UnitBook _curUnitBook in unitBookList!)
//                         UnitBookDisplay(
//                           bookData: _curUnitBook,
//                           imageWidth: 300,
//                           imageHeight: 600,
//                         ),
//                     ],
//                   ),
//                 ),
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                 crossAxisCount: 3,
                  children: <Widget>[
                for (UnitBook _curUnitBook in widget.unitBookList!)
                  UnitBookDisplay(
                      bookData: _curUnitBook,
                      imageHeight: null,
                      imageWidth: null),
              ],
            ),
          ),
        ],
      );
          }
          else if(unitBookList.hasError) {
            children=<Widget>[
              ErrorNotifier(errorMessage: '리스트를 불러오는 데 문제가 생겼어요. 잠시 후 다시 시도해주세요.',)
            ];
          }
          else {
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        }
      ),
      
      
      
      
      
      bottomNavigationBar: BottomAppBar(
        color: Color(COLOR_PRIMARY2),
        child: (widget.tag=='total')? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              onPressed: () {
                if(page<=1) null;
                else setState((){
                  page--;
                  
                });
                },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black54,
              ),
            ),
            Text('$page'),
            IconButton(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              onPressed: () async{
                setState((){
                    page++;
                });
                List<UnitBook> _temp = await _getUnitBooksList(page);
                  setState((){
                    widget.unitBookList = _temp;
                  });
                },
              icon: Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
            ),
          ],
        )
         : null,
      ),
    );
  }
}


/*
import 'package:app/components/error_notifier.dart';
import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatefulWidget {
  final List<UnitBook>? unitBookList;
  final String? tag;

  UnitLibBookListPage({this.unitBookList, this.tag});

  @override
  State<UnitLibBookListPage> createState() => _UnitLibBookListPageState();
}

class _UnitLibBookListPageState extends State<UnitLibBookListPage> {
  int page = 1;

  Future<List<UnitBook>> _getUnitBooksList(int page) async {
    if (widget.tag == 'total') {
      return await getUnitBookList(myUser!.unit, 1);
      /*for (int i = 1; i < 10; i++) {
        debugPrint(unitBookList![i].title);
        debugPrint(unitBookList![i].coverUrl);
      }*/
    } else if (widget.tag == 'best' || widget.tag == 'new') {
      return await getUnitTagBookList(myUser!.unit, widget.tag!);
    } else if (widget.tag == 'borrow') {
      return await getBorrowBookList(myUser!.unit);
    } else {
      debugPrint('unitbooklist의 태그가 잘못되었습니다 : unit_lib_content_scroll');
      return getUnitBookList_test();
    }
  }

  @override

  Widget build(BuildContext context) {
    if (widget.unitBookList == null || widget.tag == null) {
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '책 리스트를 불러오지 못했어요.',
        ),
      );
    }

    debugPrint(widget.unitBookList.toString());
    debugPrint(widget.tag);
    return Scaffold(
      appBar: AppBar(
        title: Text("${getUnitBookClassTitlebyTag(widget.tag!)} 목록"),
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              children: <Widget>[
                for (UnitBook _curUnitBook in widget.unitBookList!)
                  UnitBookDisplay(
                      bookData: _curUnitBook,
                      imageHeight: null,
                      imageWidth: null),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(COLOR_PRIMARY2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              onPressed: () {                Navigator.of(context).pop();
                },
              icon: Icon(
                Icons.chevron_left,
                color: Colors.black54,
              ),
            ),
            IconButton(
              padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
              onPressed: () {
                                Navigator.of(context).pop();
                },
              icon: Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ),
    );
  }
}

*/ 