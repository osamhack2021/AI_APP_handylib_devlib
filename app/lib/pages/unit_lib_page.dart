import 'package:app/components/unit_lib_page/unit_lib_content_scroll.dart';
import 'package:app/constants/colors.dart';
// import 'package:app/models/movie_models.dart';
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
      body: ListView(
        children: [
          /*Column(children: [
          ListTile(
            title : Text('우리 부대 인기 도서'),
            trailing: IconButton(
              icon : Icon(Icons.arrow_forward),
              onPressed :(){
                print('test');
              }
            ),
          ),
        ],),*/
          // UnitLibContentScroll(
          //   images: myList,
          //   title: '우리 부대 인기 도서',
          //   imageHeight: 194.0,
          //   imageWidth: 120.0,
          //   tag : 'popular'
          // ),
          // UnitLibContentScroll(
          //   images: myList,
          //   title: '새로 들어온 책',
          //   imageHeight: 194.0,
          //   imageWidth: 120.0,
          //   tag : 'new',
          // ),
          // UnitLibContentScroll(
          //   images: myList,
          //   title: '전체 책',
          //   imageHeight: 194.0,
          //   imageWidth: 120.0,
          //   tag : 'total'
          // ),
        ],
      ),
    );
  }
}
