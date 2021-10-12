import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class UnitLibContentScroll extends StatelessWidget {
  final String tag;

  UnitLibContentScroll({
    required this.tag
  });
  List<UnitBook>? unitBookList =  getUnitBookList_test();

  Future<void> getTotalList() async {
    if(tag == 'total'){
      unitBookList = await getUnitBookList(myUser!.unit);
      debugPrint('total list loaded');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    
    getTotalList();
    return Card(
      
      margin:EdgeInsets.all(1.0),
      child: Column(
        children: [
          ListTile(
            title:Text("${getUnitBookClassTitlebyTag(tag)}"), 
            trailing: 
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/home/unitlib/list',
                  arguments : tag
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              
              itemBuilder: (BuildContext context, int index) {
                return 
                  UnitBookDisplay(
                    bookData : unitBookList![index],
                    imageHeight:bookImageHeightConst,
                    imageWidth:bookImageWidthConst
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}

