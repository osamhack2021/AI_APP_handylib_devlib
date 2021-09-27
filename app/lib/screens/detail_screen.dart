import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app/models/book_models.dart';

import 'package:app/components/circular_clipper.dart';
import 'package:app/components/content_scroll.dart';

class DetailScreen extends StatefulWidget {
  final Book book;

  DetailScreen({required this.book});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 6.0),
                child: Container(
                  transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Opacity(
                        opacity: 0.83,
                        child: Image(
                            height: 400.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: AssetImage(widget.book.imageUrl),
                            colorBlendMode: BlendMode.modulate)),
                  ),
                ), // Widget that is blurred
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 100),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(110, 20, 110, 0),
                child: Hero(
                  tag: widget.book.imageUrl,
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(widget.book.imageUrl),
                          colorBlendMode: BlendMode.modulate)),
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(left: 30.0),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.white,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.book.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.book.categories,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            '출판일',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          widget.book.year.toString(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '출판사',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          widget.book.country.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '별점',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${widget.book.length} min',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 120.0,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.book.description,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
