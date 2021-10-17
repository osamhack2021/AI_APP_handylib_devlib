import 'dart:convert';

import 'package:app/components/titled_appbar.dart';
import 'package:app/components/underlined_text.dart';
import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/components/unit_lib_page/unit_lib_content_scroll.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/uri.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyBookPage extends StatefulWidget {
  MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

Future<String> loadUserImage(String userId) async {
  final response = await http.get(
    Uri.parse(myUri + 'mypage' + '?user_id=${userId}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return (jsonDecode(utf8.decode(response.bodyBytes)))['user_data'];
  } else {
    throw Exception('Failed to load User data');
  }
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitledAppbar("나의 서재"),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          const Align(
                              alignment: Alignment.bottomLeft,
                              child: UnderLinedText(
                                  text: "나의 취향 분석", thickness: 7)),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  'https://www.projectlib.tk/image/${myUser!.userId}.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ]))),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 10,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: UnitLibContentScroll(tag: 'borrow')),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
