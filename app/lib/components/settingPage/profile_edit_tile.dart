import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileEditTile extends StatelessWidget {

  final String? text, param;

  const ProfileEditTile(
     {
       required this.text, 
       required this.param
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap:() {
          null;
        },
        title:Text('${text} : ${param}'),
        trailing: Icon(
          Icons.create,
        ),
      ),
    );
  }
}