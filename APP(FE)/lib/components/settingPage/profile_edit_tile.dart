import 'package:app/components/settingPage/show_modify_dialog.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileEditTile extends StatefulWidget {
  String title;
  Function() callback;

  ProfileEditTile(this.title,this.callback);

  @override
  State<ProfileEditTile> createState() => _ProfileEditTileState();
}

class _ProfileEditTileState extends State<ProfileEditTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(
                '${getPropertyTitle(myUser!, widget.title)} : ${getPropertyValue(myUser!, widget.title)}'),
            trailing: IconButton(
                icon: Icon(
                  Icons.create,
                ),
                onPressed: () async {
                  showModifyDialog(context, widget.title,widget.callback);
                })));
  }
}
