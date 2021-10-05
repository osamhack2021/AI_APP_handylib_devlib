import 'package:flutter/material.dart';
import 'package:app/components/homeScreen/feed_page_appbar.dart';
import 'package:app/models/book_models.dart';
import 'package:app/components/homeScreen/book_selector.dart';
import 'package:app/components/homeScreen/content_scroll.dart';
import 'package:app/hooks/use_api.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final PageController _topPageController =
      PageController(initialPage: 0, viewportFraction: 0.6);

  Future<List<List<Book>>>? data;

  List<int> isbnList = [
    9788901252438,
    9791160947540,
    9791165797096,
    9791197549304,
    9788954682152
  ];
  List<int> isbnList2 = [
    9788956609959,
    9788956604992,
    9788956607030,
    9791189982140,
    9788956602998
  ];

  Future<List<List<Book>>> fetchData() async {
    List<List<Book>> bookData = [];
    String host = "www.aladin.co.kr";
    String path = "ttb/api/ItemLookUp.aspx";
    List<Book> tmpBook = [];
    for (int isbn13 in isbnList) {
      tmpBook.add(Book.fromJson(
          await apiGet(aladinParam(isbn13.toString()), host, path)));
    }
    bookData.add(tmpBook);
    tmpBook = [];
    for (int isbn13 in isbnList2) {
      tmpBook.add(Book.fromJson(
          await apiGet(aladinParam(isbn13.toString()), host, path)));
    }
    bookData.add(tmpBook);
    return bookData;
  }

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeedPageAppBar(),
        body: FutureBuilder<List<List<Book>>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  SizedBox(
                    height: 360.0,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _topPageController,
                      itemCount: snapshot.data![0].length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookSelector(index, snapshot.data![0][index],
                            _topPageController, context);
                      },
                    ),
                  ),
                  ContentScroll(
                    snapshot.data == null ? [] : snapshot.data![1],
                    '정유정',
                    250.0,
                    150.0,
                  ),
                  // SizedBox(height: 10.0),
                  // ContentScroll(
                  //   images: popular,
                  //   title: 'Popular',
                  //   imageHeight: 250.0,
                  //   imageWidth: 150.0,
                  // ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // 기본적으로 로딩 Spinner를 보여줍니다.
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
