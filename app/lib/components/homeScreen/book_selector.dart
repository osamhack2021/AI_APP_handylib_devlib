import 'package:flutter/material.dart';
import 'package:app/screens/detail_screen.dart';
import 'package:app/models/book_models.dart';

BookSelector(int index, Book book, PageController _pageController,
    BuildContext context) {
  return AnimatedBuilder(
    animation: _pageController,
    builder: (context, widget) {
      double value = 1;
      if (_pageController.position.haveDimensions) {
        value = _pageController.page! - index;
        value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
      }
      return new Center(
        child: SizedBox(
          height: Curves.easeInOut.transform(value) * 400.0,
          width: Curves.easeInOut.transform(value) * 260.0,
          child: widget,
        ),
      );
    },
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailScreen(book: book),
        ),
      ),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0.0, 4.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Center(
            child: Hero(
              tag: book.coverUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image(
                  image: AssetImage(book.coverUrl),
                  height: 400.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
