import 'package:flutter/material.dart';
import 'package:app/components/homeScreen/feed_page_appbar.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // PageController _pageController;

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 1, viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FeedPageAppBar(),
    );
  }
}
