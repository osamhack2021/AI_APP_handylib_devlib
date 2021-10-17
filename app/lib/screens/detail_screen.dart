import 'dart:ui';

import 'package:app/components/ellipsis_text.dart';
import 'package:app/components/error_notifier.dart';
import 'package:app/constants/colors.dart';
import 'package:app/hooks/use_api.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/models/book_models.dart';
import 'package:app/components/homeScreen/clipped_image_view.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  DetailScreen({required this.book});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Widget currentClippedImageView;

  void initState() {
    super.initState();
    currentClippedImageView = ClippedImageView(
        context, widget.book.coverUrl, widget.book.isbn, callback);
  }

  void callback() {
    setState(() {
      currentClippedImageView = ClippedImageView(
          context, widget.book.coverUrl, widget.book.isbn, callback);
    });
  }

  Widget title_subtitle_tile(String _title, String _subtitle) {
    return Expanded(
      flex: 1,
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              _title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
          ),
          Text(
            _subtitle,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// 대여하기/대여불가능(부대에 없음), 누군가가 대여중입니다./대여중
// enum BookStatusType {
//   available,
//   unavailableNobook,
//   unavailableBorrowing,
//   borrowing
// }

  Future<Map<String, dynamic>>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          currentClippedImageView,

  void initState() {
    super.initState();
    data = getUnitBookInfo(myUser!.unit, widget.book.isbn);
  }

  void handleBorrow() async {
    borrowUnitBook(myUser!.unit, widget.book.isbn, myUser!.userId)
        .then((value) {
      if (value == 200) {
        final snackbar = SnackBar(content: Text('성공적으로 대여하였습니다.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        final snackbar = SnackBar(content: Text('대여에 실패하였습니다.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });

    data = getUnitBookInfo(myUser!.unit, widget.book.isbn);
    setState(() {});
  }

  void handleReturn() {
    returnUnitBook(myUser!.unit, widget.book.isbn, myUser!.userId)
        .then((value) {
      if (value == 200) {
        final snackbar = SnackBar(content: Text('성공적으로 반납하였습니다.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else {
        final snackbar = SnackBar(content: Text('반납에 실패하였습니다.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });

    data = getUnitBookInfo(myUser!.unit, widget.book.isbn);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ClippedImageView(context, widget.book.coverUrl, widget.book.isbn),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                EllipsisText(
                    350,
                    widget.book.title,
                    const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      widget.book.category,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 55,
                  width: size.width,
                  child: _builder(data, (snapshotData) {
                    BookStatusType status;
                    bool flag = true;
                    if (snapshotData!["Error"] != null) {
                      status = BookStatusType.unavailableNobook;
                      flag = false;
                    } else if (snapshotData["books_list"][0]["state"] == 0) {
                      status = BookStatusType.available;
                    } else {
                      if (snapshotData["books_list"][0]["user_id"] ==
                          myUser!.userId) {
                        status = BookStatusType.borrowing;
                      } else {
                        status = BookStatusType.unavailableBorrowing;
                        flag = false;
                      }
                    }
                    return Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: bookStatusColorMap[status],
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        onTap: () {
                          if (status == BookStatusType.available) {
                            handleBorrow();
                          } else if (status == BookStatusType.borrowing) {
                            handleReturn();
                          }
                        },
                        enabled: flag,
                        leading: Icon(Icons.book_outlined, size: 35),
                        title: Text(bookStatusMap[status]!),
                      ),
                    );
                  }),
                ),
                const Divider(
                  height: 20,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    title_subtitle_tile('저자', widget.book.author),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    title_subtitle_tile('출판일', widget.book.pubDate),
                    title_subtitle_tile('출판사', widget.book.publisher),
                  ],
                ),
                Divider(
                  height: 30,
                  thickness: 3,
                ),
                Container(
                  child: Text(
                    widget.book.description,
                    style: TextStyle(color: Colors.black87, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> _builder(
      Future<Map<String, dynamic>>? expectedFuture,
      Function(Map<String, dynamic>? snapshotData) success) {
    return FutureBuilder<Map<String, dynamic>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return success(snapshot.data);
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return ErrorNotifier(errorMessage: '서버와의 연결이 불안정합니다.');
          }
          // 기본적으로 로딩 Spinner를 보여줍니다.
          return const Center(
              child: CircularProgressIndicator(color: Color(COLOR_PRIMARY)));
        });
  }
}
