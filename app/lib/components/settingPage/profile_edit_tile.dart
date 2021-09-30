import 'package:app/components/settingPage/show_modify_dialog.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';

class ProfileEditTile extends StatelessWidget {

  String title;
  User myUser;

  ProfileEditTile(this.myUser, this.title);  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap:() {
          null;
        },
        title:Text('${getPropertyTitle(myUser,title)} : ${getPropertyValue(myUser, title)}'),
        trailing: IconButton(
          icon: Icon(
            Icons.create,

          ),
          onPressed: () => {
            showModifyDialog(context, title)            
          },
        ),
      ),
    );
  }

  
}