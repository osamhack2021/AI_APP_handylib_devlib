import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:flutter/material.dart';

class UnitLibBookListPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final List<Map> myProducts =
      List.generate(100, (index) => {"id": index, "name": "Product $index"})
          .toList();
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return UnitBookDisplay(imageHeight: 150, imageWidth: 150);
              /*Container(
                alignment: Alignment.center,
                child: Text(myProducts[index]["name"]),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
              );*/
            }),
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