import 'package:app/components/default_circle_avatar.dart';
import 'package:app/components/settingPage/profile_edit_tile.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

final TextEditingController modifySettingController = TextEditingController();

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("나의 프로필")),
        backgroundColor: const Color(COLOR_PRIMARY),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          SizedBox(height:large_gap),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            DefaultCircleAvatar(size:50),
          ]),
          SizedBox(height : large_gap),
          ListTile(title:Text('아이디 : ${getPropertyValue(myUser!, 'userId')}')),
          ProfileEditTile(myUser!, "name"),
          ProfileEditTile(myUser!, "password"),
          ProfileEditTile(myUser!, "email"),
          ProfileEditTile(myUser!, "unit"),
          ProfileEditTile(myUser!, "rank"),
          
        ]),
      ),
    );
  }
}


