import 'dart:io';

import 'package:app/components/default_circle_avatar.dart';
import 'package:app/components/error_notifier.dart';
import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/components/settingPage/profile_edit_tile.dart';
import 'package:app/constants/colors.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/components/titled_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, TextEditingController> modifySettingController = {
  "email": TextEditingController(),
  "unit": TextEditingController(),
  "rank": TextEditingController()
};

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  File? _profileImage;
  ImagePicker imagePicker = ImagePicker();

  void fetchProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath;
    imagePath = prefs.getString('profileImage');
    setState(() {
      _profileImage = imagePath == null ? null : File(imagePath);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  _onCameraClick() async {
    ImagePicker _imagePicker = imagePicker;
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (image != null) {
      prefs.setString('profileImage', image.path);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _profileImage = File(image.path);
        });
        final snackbar = SnackBar(content: Text('성공적으로 변경되었습니다.'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (myUser == null)
      return Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );

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
              child: SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: _onCameraClick,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    _profileImage != null
                                        ? CircleAvatar(
                                            radius: 100,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: SizedBox(
                                                width: 190,
                                                height: 190,
                                                child: Image.file(
                                                  _profileImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const DefaultCircleAvatar(size: 80),
                                    Positioned(
                                      left: 80,
                                      right: 0,
                                      child: FloatingActionButton(
                                          backgroundColor: Color(COLOR_PRIMARY),
                                          child: Icon(Icons.camera_alt),
                                          mini: true,
                                          onPressed: _onCameraClick),
                                    )
                                  ],
                                )),
                          ),
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

                          RoundedButton(
                            text: "로그아웃",
                            press: () {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                final snackbar =
                                    SnackBar(content: Text('성공적으로 로그아웃되었습니다.'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                                Navigator.of(context)
                                    .pushReplacementNamed('/auth/login');
                              });
                            },
                          ),
                        ],
                      ),
                    )),
              )),
        ));
  }
}
