import 'package:app/constants/colors.dart';
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
        title: Center(child: Text("My Profile")),
        backgroundColor: Color(COLOR_PRIMARY),
      ),
      body: ListView(children: [
        const CircleAvatar(
          backgroundImage: AssetImage(
            'default_profile_image.png',
          ),
        )
      ]),
    );
  }
}
