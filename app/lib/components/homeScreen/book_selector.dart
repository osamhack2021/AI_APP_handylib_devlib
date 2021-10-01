import 'package:flutter/material.dart';
import 'package:app/screens/movie_screen.dart';
import 'package:app/models/movie_models.dart';

BookSelector(int index, PageController _pageController, BuildContext context) {
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
          height: Curves.easeInOut.transform(value) * 270.0,
          width: Curves.easeInOut.transform(value) * 400.0,
          child: widget,
        ),
      );
    },
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MovieScreen(movie: movies[index]),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
                  tag: movies[index].imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage(movies[index].imageUrl),
                      height: 220.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Text(
                movies[index].title,
                style: TextStyle(
                  color: Colors.white,
                  // backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
