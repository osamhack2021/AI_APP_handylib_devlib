import 'package:flutter/material.dart';
import 'package:app/components/homeScreen/feed_page_appbar.dart';
import 'package:app/models/movie_models.dart';
import 'package:app/components/homeScreen/book_selector.dart';
import 'package:app/components/content_scroll.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  PageController _topPageController =
      PageController(initialPage: 1, viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 1, viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeedPageAppBar(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 280.0,
              width: double.infinity,
              child: PageView.builder(
                controller: _topPageController,
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookSelector(index, _topPageController, context);
                },
              ),
            ),
            ContentScroll(
              images: myList,
              title: 'My List',
              imageHeight: 250.0,
              imageWidth: 150.0,
            ),
            SizedBox(height: 10.0),
            ContentScroll(
              images: popular,
              title: 'Popular',
              imageHeight: 250.0,
              imageWidth: 150.0,
            ),
          ],
        ));
  }
}
