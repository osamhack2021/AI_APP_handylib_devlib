import 'package:app/components/unit_lib_page/unit_book_display.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/models/unit_book_models.dart';
import 'package:flutter/material.dart';

class UnitBookDetailPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    
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
                width:150,
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
                    image: AssetImage('images/default_book_cover_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
  ],
),

          ListTile(
            title: Text("BookName"),
          ),
          
          TextButton(
            onPressed: (){},
            child: Text("대출 가능"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Book Detail : Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
          ),
          
        ],
        
      )
    );
  }
}