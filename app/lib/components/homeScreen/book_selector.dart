import 'package:flutter/material.dart';
import 'package:app/screens/detail_screen.dart';
import 'package:app/models/book_models.dart';
import 'package:transparent_image/transparent_image.dart';

BookSelector(int index, Book book, PageController _pageController,
    BuildContext context) {
  return GestureDetector(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(book: book),
            ),
          ),
      child: Center(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image(
                          image: NetworkImage(book.coverUrl),
                          height: 240.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(book.title,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                            const Divider(
                              height: 30,
                              endIndent: 10,
                              indent: 10,
                              color: Colors.black12,
                              thickness: 3,
                            ),
                            Text("지은이: " + book.author),
                            const Divider(
                              height: 30,
                              endIndent: 10,
                              indent: 10,
                              color: Colors.black12,
                              thickness: 3,
                            ),
                            Text(book.category),
                          ],
                        ),
                      )
                    ]),
              ),
            )),
      ));
}
