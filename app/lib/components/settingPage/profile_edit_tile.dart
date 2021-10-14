import 'package:app/components/settingPage/show_modify_dialog.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';

class ProfileEditTile extends StatefulWidget {
  String title;
  User myUser;

  ProfileEditTile(this.myUser, this.title);

  @override
  State<ProfileEditTile> createState() => _ProfileEditTileState();
}

class _ProfileEditTileState extends State<ProfileEditTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            onTap: () {
              null;
            },
            title: Text(
                '${getPropertyTitle(widget.myUser, widget.title)} : ${getPropertyValue(widget.myUser, widget.title)}'),
            trailing: IconButton(
                icon: Icon(
                  Icons.create,
                ),
                onPressed: () => {
                      showModifyDialog(context, widget.title),
                      
                    })));
  }
}
