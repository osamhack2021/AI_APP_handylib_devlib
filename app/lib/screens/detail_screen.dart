import 'dart:ui';

import 'package:app/components/ellipsis_text.dart';
import 'package:app/components/error_notifier.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: <Widget>[
          ClippedImageView(context, widget.book.coverUrl),
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
                const SizedBox(height: 10.0),
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
}
