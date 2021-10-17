import 'dart:convert';

import 'package:app/constants/colors.dart';
import 'package:app/constants/uri.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:app/components/homeScreen/circular_clipper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

Future<bool> _getLike(String isbn) async {
  final response = await http.get(
    Uri.parse(myUri + 'like/?user_id=${myUser!.userId}&isbn=${isbn}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  String _res = jsonDecode(utf8.decode(response.bodyBytes))['message'];
  if (_res == "False")
    return false;
  else if (_res == "True")
    return true;
  else
    throw Exception("_getLike value is invalid. : clipped_image_view.dart");
}

Future<bool> _postLike(String isbn) async {
  final response = await http.post(
    Uri.parse(myUri + 'like/?user_id=${myUser!.userId}&isbn=${isbn}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  String _res = jsonDecode(utf8.decode(response.bodyBytes))['message'];
  if (_res == "delete")
    return false;
  else if (_res == "append")
    return true;
  else
    throw Exception("_getLike value is invalid. : clipped_image_view.dart");
}

/*
class ClippedImageViewClass extends StatelessWidget {
  final BuildContext? context;
  final String? imageUrl ,isbn;

  const ClippedImageViewClass({Key? key, this.context, this.imageUrl, this.isbn}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return ClippedImageView(context, imageUrl!, isbn!);
  }
}*/

Widget ClippedImageView(
    BuildContext context, String _imageUrl, String _isbn, Function _callback) {
  return Stack(
    children: <Widget>[
      ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 6.0),
        child: Container(
          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
          child: ClipShadowPath(
            clipper: CircularClipper(),
            shadow: const Shadow(blurRadius: 20.0),
            child: Opacity(
              opacity: 1,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: _imageUrl,
                height: 400.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ), // Widget that is blurred
      ),
      Container(
          // padding: EdgeInsets.symmetric(horizontal: 100),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(110, 20, 110, 0),
          child: Center(
            child: Hero(
              tag: _imageUrl,
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
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: _imageUrl,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  )),
            ),
          )),
      Positioned(
        left: 20,
        top: 5,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(COLOR_PRIMARY).withOpacity(0.5),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      Positioned(
        right: 30,
        top: 300,
        child: FutureBuilder<bool>(
            future: _getLike(_isbn),
            builder: (BuildContext context, _liked) {
              if (_liked.hasData) {
                bool _currentLike = _liked.data!;
                return IconButton(
                  icon: (_currentLike)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  color: Colors.red,
                  iconSize: 40,
                  onPressed: () async {
                    _currentLike = await _postLike(_isbn);
                    _callback();
                    
                    if(_currentLike) {
                      final snackbar = SnackBar(content: Text('책을 좋아요 했습니다.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                    else {
                      final snackbar = SnackBar(content: Text('책을 좋아요 취소했습니다.'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.favorite_border_outlined),
                  color: Colors.black26,
                  iconSize: 40,
                  onPressed: null,
                );
              }
            }),
      )
    ],
  );
}
