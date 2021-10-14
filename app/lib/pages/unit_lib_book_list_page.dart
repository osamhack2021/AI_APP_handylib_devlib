import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/models/unit_book_class_models.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    String tag = ModalRoute.of(context)!.settings.arguments as String;
    
    final List<Map> myProducts =
      List.generate(100, (index) => {"id": index, "name": "Product $index"})
          .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("${getUnitBookClassTitlebyTag(tag)} 목록"),
        backgroundColor: Color(COLOR_PRIMARY),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1.6,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: myProducts.length,
              itemBuilder: (BuildContext ctx, index) {
                return UnitBookDisplay();
              }), 
      ),
      //ListView(children: <Widget>[
        /*GridView.builder(
          primary:true,
          gridDelegate: ( 
            SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 3
            )
          ),
          itemCount: 10,
          itemBuilder: (
            (BuildContext context, int index) {
              return Card(
          color: Colors.amber,
          child: Center(child: Text('$index')),
        );
            }
          ),
        ),*/
     // ],
     // ),
    );
  }
}