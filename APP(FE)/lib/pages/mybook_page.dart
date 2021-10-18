import 'dart:convert';
import 'dart:typed_data';

import 'package:app/components/error_notifier.dart';
import 'package:app/components/titled_appbar.dart';
import 'package:app/components/underlined_text.dart';
import 'package:app/components/unit_lib_page/unit_lib_content_scroll.dart';
import 'package:app/constants/colors.dart';

import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

/* the NonCacheNetworkImage class is from 
https://stackoverflow.com/questions/68784559/how-to-prevent-caching-images-from-network-flutter
*/

class NonCacheNetworkImage extends StatelessWidget {
  const NonCacheNetworkImage(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;
  Future<Uint8List> getImageBytes() async {
    Response response = await get(
        Uri.parse(imageUrl + "?" + Random().nextInt(10000000).toString()));
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: getImageBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Image.memory(snapshot.data!, fit: BoxFit.fill);
        return ErrorNotifier(errorMessage: '취향 분석 데이터를 불러오지 못했습니다.');
      },
    );
  }
}

class MyBookPage extends StatefulWidget {
  MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  Future<bool>? imgFlag;
  Future<bool> buildImg() async {
    const String myUri = 'https://www.projectlib.tk';
    http.Response response = await http.get(
        Uri.parse(myUri + "/mypage?user_id=" + myUser!.userId),
        headers: {"Accept": "application/json"});
    return true;
  }

  @override
  void initState() {
    super.initState();
    imgFlag = buildImg();
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
                              boxShadow: const [],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FutureBuilder<bool>(
                                  future: imgFlag,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.network(
                                          'https://www.projectlib.tk/image/${myUser!.userId}.png?' +
                                              Random()
                                                  .nextInt(1000000)
                                                  .toString());
                                    } else if (snapshot.hasError) {
                                      return ErrorNotifier(
                                          errorMessage: "이미지를 불러올 수 없습니다.");
                                    }
                                    // 기본적으로 로딩 Spinner를 보여줍니다.
                                    return Column(children: const [
                                      SizedBox(
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Color(COLOR_PRIMARY)),
                                        )),
                                        width: 60,
                                        height: 120,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Text('인공지능이 이미지를 생성중입니다..'),
                                      )
                                    ]);
                                  },
                                )

                                /*Image.network(
                                  'https://www.projectlib.tk/image/${myUser!.userId}.png',
                                  
                                  fit: BoxFit.cover,
                                )*/
                                ),
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
