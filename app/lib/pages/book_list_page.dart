
import 'package:app/components/book_list_item.dart';
import 'package:flutter/material.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Colors.white,
      appBar: _buildBookListAppBar(),
      body : Column(
        children: [
          //BookTitle(),
          //BookListMenu(),
          BookListItem("book name", "Mybook", "explanation"),
        ]
      ),
    );
  }

  AppBar _buildBookListAppBar() => AppBar(
    title: const Text(
      "MyTitle",
     style: TextStyle(color:Colors.black),
     ),
    backgroundColor: Colors.white,
    actions: [
      Icon(
        Icons.add_alert,
        color:Colors.black,
        ),
      SizedBox(width:16),
      Icon(
        Icons.search,
        color:Colors.black,
      ),
      SizedBox(width:16),
    ],
  );
}