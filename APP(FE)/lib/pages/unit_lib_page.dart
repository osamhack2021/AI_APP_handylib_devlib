import 'package:app/components/error_notifier.dart';
import 'package:app/components/unit_lib_page/unit_lib_content_scroll.dart';
import 'package:app/constants/colors.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UnitLibPage extends StatefulWidget {
  const UnitLibPage({Key? key}) : super(key: key);

  @override
  _UnitLibPageState createState() => _UnitLibPageState();
}

class _UnitLibPageState extends State<UnitLibPage> {
  @override
  Widget build(BuildContext context) {
    if (myUser == null)
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
      
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('${myUser!.unit} 도서관'),
        backgroundColor: Color(COLOR_PRIMARY),
      ),
      body: ListView(children: [
        UnitLibContentScroll(
          tag : 'best'
        ),
        UnitLibContentScroll(
          tag : 'new',
        ),
        UnitLibContentScroll(
          tag : 'total'
        ),
      ],),
    );
  }
}
