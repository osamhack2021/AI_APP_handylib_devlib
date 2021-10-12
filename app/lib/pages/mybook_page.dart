import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/components/unit_lib_page/unit_lib_content_scroll.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class MyBookPage extends StatefulWidget {
  MyBookPage({Key? key}) : super(key: key);

  @override
  _MyBookPageState createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text("나의 서재"),
        backgroundColor: Color(COLOR_PRIMARY),
      ),
      body: ListView(children:[
        Card(child:
          UnitLibContentScroll(
            tag : 'borrowed'
          ),
        ),
        Card(child:
            Column(children:[
              ListTile(
                title: Text("나의 취향 분석"),

              ),
               Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: AssetImage('images/sample_graph_image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

            ]
            )
        )
      ],
      )
    );
  }
}
