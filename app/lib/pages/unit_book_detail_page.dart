import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:flutter/material.dart';

class UnitBookDetailPage extends StatelessWidget {
  UnitBook? bookData;

  @override
  Widget build(BuildContext context) {

    bookData = ModalRoute.of(context)!.settings.arguments as UnitBook?;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(COLOR_PRIMARY),
        ),
        body: ListView(
          children: [
            SizedBox(height: large_gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  height: 200,
                  width: 150,
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
                      child: (bookData!.coverUrl == null)
                          ? (Image(
                              image: AssetImage(
                                  'images/default_book_cover_image.png'),
                              fit: BoxFit.cover,
                            ))
                          : (Image.network(
                              '${bookData!.coverUrl!.replaceAll('\\/', '/')}',
                              fit: BoxFit.cover,
                            ))),
                ),
              ],
            ),
            ListTile(
              title: Text(
                "${bookData!.title}",
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:26,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child : Text('${bookData!.category}')
            ),
            TextButton(
              onPressed: () {},
              child: Text("대출 가능"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('${bookData!.description}')
            ),
          ]
        ),
      );
    }  
}
