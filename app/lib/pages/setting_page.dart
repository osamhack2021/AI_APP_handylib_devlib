import 'package:app/components/settingPage/profile_edit_tile.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/size.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
           CircleAvatar(
            backgroundImage: (
              AssetImage('default_profile_image.png')
            ),
            backgroundColor: Color(COLOR_PRIMARY),
            radius : 50,
          ),
          SizedBox(height : large_gap),
          ListTile(title:Text('id : ${id}')),
          ProfileEditTile(text:'이름',param:'Jordano'),
          ProfileEditTile(text: 'email', param: 'abc@efg.com')
        ]),
      ),
    );
  }
}


