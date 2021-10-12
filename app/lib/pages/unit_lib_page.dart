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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('${myUser!.unit} 도서관'),
        backgroundColor: Color(COLOR_PRIMARY),
      ),
      body: ListView(children: [
        UnitLibContentScroll(
          tag : 'popular'
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
