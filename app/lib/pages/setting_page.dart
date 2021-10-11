import 'package:app/components/default_circle_avatar.dart';
import 'package:app/components/settingPage/profile_edit_tile.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/components/titled_appbar.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: TitledAppbar("나의 프로필"),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 10,
            child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: DefaultCircleAvatar(size: 80)),
                      const SizedBox(height: 35),
                      Text(
                        myUser!.username,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        myUser!.userId,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black54),
                      ),
                      // ProfileEditTile(myUser!, "username"),
                      ProfileEditTile(myUser!, "email"),
                      ProfileEditTile(myUser!, "unit"),
                      ProfileEditTile(myUser!, "rank"),
                      const SizedBox(height: 15),
                    ],
                  ),
                )),
          ),
        ));
  }
}
