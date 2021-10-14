import 'dart:io';

import 'package:app/components/default_circle_avatar.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/components/underlined_text.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:app/components/homeScreen/feed_page_appbar.dart';
import 'package:app/models/book_models.dart';
import 'package:app/components/homeScreen/book_selector.dart';
import 'package:app/components/homeScreen/content_scroll.dart';
import 'package:app/hooks/use_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final PageController _topPageController =
      PageController(initialPage: 0, viewportFraction: 0.6);

  Future<List<Book>>? jinjungList;
  List<Future<List<Book>>> categoryList = [];
  List<String> categoryName = [];
  final Map<String, bool> filter = {};
  File? _profileImage;
  SharedPreferences? prefs;

  void fetchPref() async {
    prefs = await SharedPreferences.getInstance();
    String imagePath;
    imagePath = prefs!.getString('profileImage')!;

    categoryMap.forEach((key, value) {
      filter[value] = prefs!.getBool(value) ?? true;
    });

    setState(() {
      _profileImage = File(imagePath);
    });
  }

  Future<List<Book>> fetchJinjung() async {
    List<Book> tmpBook = [];
    for (int isbn13 in jinjungIsbnList) {
      tmpBook.add(Book.fromJson(await feedAladinApiGet(isbn13.toString())));
    }
    return tmpBook;
  }

  Future<List<Book>> fetchCategory(int categoryNum) async {
    List<Book> books = [];
    List<dynamic> res;
    res = (await feedAladinCategoryApi(categoryNum, 1))["item"];
    for (var item in res) {
      item["description"] = item["description"]
          .replaceAllMapped(RegExp('(&lt;)|(&gt;)|(<.+?\/>)'), (Match m) => "");
      books.add(Book.fromJson(item));
    }
    return books;
  }

  @override
  void initState() {
    super.initState();
    fetchPref();
    jinjungList = fetchJinjung();
    categoryMap.forEach((key, value) {
      categoryList.add(fetchCategory(key));
      categoryName.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FeedPageAppBar(context),
        drawer: NavDrawer(),
        body: ListView(
          children: <Widget>[
            jinjungTitle(),
            SizedBox(
                height: 360.0,
                width: double.infinity,
                child: _builder(jinjungList, (data) {
                  return PageView.builder(
                    controller: _topPageController,
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookSelector(
                          index, data[index], _topPageController, context);
                    },
                  );
                })),
            Column(
              children: _categoryBuilder(),
            )
          ],
        ));
  }

  Drawer NavDrawer() {
    List<Widget> drawerOptions = [];
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(COLOR_PRIMARY)),
            accountName: Text(myUser!.username),
            accountEmail: Text(myUser!.userId),
            currentAccountPicture: _profileImage != null
                ? CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                        width: 190,
                        height: 190,
                        child: Image.file(
                          _profileImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : const DefaultCircleAvatar(size: 80),
          ),
          Column(children: drawerChildren()),
        ],
      ),
    ));
  }

  List<Widget> drawerChildren() {
    List<Widget> tmp = [];
    filter.forEach((key, value) {
      tmp.add(ListTile(
        trailing: Switch(
          activeColor: Color(COLOR_PRIMARY),
          hoverColor: Color(COLOR_PRIMARY2),
          value: value,
          onChanged: (value) {
            setState(() {
              filter[key] = value ? true : false;
              prefs!.setBool(key, filter[key]!);
            });
          },
        ),
        title: Text(key),
      ));
    });

    return tmp;
  }

  List<Widget> _categoryBuilder() {
    List<Widget> tmp = [];
    for (int i = 0; i < categoryList.length; i++) {
      tmp.add(Visibility(
          visible: filter[categoryName[i]]!,
          child: SizedBox(
              width: double.infinity,
              height: 290,
              child: _builder(categoryList[i], (snapshotData) {
                return ContentScroll(
                  snapshotData ?? [],
                  categoryName[i],
                  250.0,
                  150.0,
                );
              }))));
    }
    return tmp;
  }

  Container jinjungTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(50.0, 10, 150, 0),
      width: double.infinity,
      child: const UnderLinedText(
        text: "이번분기의 진중문고",
        thickness: 7,
        style: TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  FutureBuilder<List<Book>> _builder(Future<List<Book>>? expectedFuture,
      Function(List<Book>? snapshotData) success) {
    return FutureBuilder<List<Book>>(
        future: expectedFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return success(snapshot.data);
          } else if (snapshot.hasError) {
            return Container();
          }
          // 기본적으로 로딩 Spinner를 보여줍니다.
          return const Center(
              child: CircularProgressIndicator(color: Color(COLOR_PRIMARY)));
        });
  }
}
