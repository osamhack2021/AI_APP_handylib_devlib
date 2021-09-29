import 'package:flutter/material.dart';
import 'package:app/components/homeScreen/feed_page_appbar.dart';
import 'package:app/models/book_models.dart';
import 'package:app/components/homeScreen/book_selector.dart';
import 'package:app/components/homeScreen/content_scroll.dart';
import 'package:app/hooks/useApi.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  PageController _topPageController =
      PageController(initialPage: 0, viewportFraction: 0.6);

  List<Book> bookData = [];

  List<int> isbnList = [
    9788901252438,
    9791160947540,
    9791165797096,
    9791197549304,
    9788954682152
  ];

  void apiCall(int isbn13) async {
    Map<String, dynamic> param = aladinParam(isbn13.toString());
    String host = "www.aladin.co.kr";
    String path = "ttb/api/ItemLookUp.aspx";
    bookData.add(Book.fromJson(await api_get(param, host, path)));
    print(bookData.length);
  }

  void fetchData() async {
    isbnList.forEach((isbnNum) {
      apiCall(isbnNum);
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeedPageAppBar(),
        body: bookData.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  Container(
                    height: 360.0,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _topPageController,
                      itemCount: bookData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookSelector(index, bookData[index],
                            _topPageController, context);
                      },
                    ),
                  ),
                  // ContentScroll(
                  //   books: myList,
                  //   listTitle: 'My List',
                  //   imageHeight: 250.0,
                  //   imageWidth: 150.0,
                  // ),
                  // SizedBox(height: 10.0),
                  // ContentScroll(
                  //   images: popular,
                  //   title: 'Popular',
                  //   imageHeight: 250.0,
                  //   imageWidth: 150.0,
                  // ),
                ],
              ));
  }
}
