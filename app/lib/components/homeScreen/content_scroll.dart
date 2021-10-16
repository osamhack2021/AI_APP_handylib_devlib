import 'package:app/components/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/detail_screen.dart';
import 'package:app/models/book_models.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ContentScroll extends StatelessWidget {
  final List<Book> books;
  final String listTitle;
  final double imageHeight;
  final double imageWidth;

  ContentScroll(
    this.books,
    this.listTitle,
    this.imageHeight,
    this.imageWidth,
  );

  _onStartScroll(ScrollMetrics metrics) {
    print("Scroll Start");
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    print("Scroll Update");
  }

  _onEndScroll(ScrollMetrics metrics) {
    print("Scroll End");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 0),
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: UnderLinedText(
                text: listTitle,
                thickness: 7,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        SizedBox(
            height: imageHeight,
            child: books.isEmpty == true
                ? const Center(
                    child: Text("결과가 없습니다.",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)))
                : NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      // if (scrollNotification is ScrollStartNotification) {
                      //   _onStartScroll(scrollNotification.metrics);
                      // } else if (scrollNotification
                      //     is ScrollUpdateNotification) {
                      //   _onUpdateScroll(scrollNotification.metrics);
                      // } else if (scrollNotification is ScrollEndNotification) {
                      //   _onEndScroll(scrollNotification.metrics);
                      // }
                      // print(scrollNotification );
                      return true;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(book: books[index]),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 20.0,
                            ),
                            width: imageWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: FadeInImage.memoryNetwork(
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return const Center(
                                      child: Text("결과가 없습니다.",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )));
                                },
                                placeholder: kTransparentImage,
                                image: books[index].coverUrl,
                                height: 400.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),
      ],
    );
  }
}
