// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:app/components/default_circle_avatar.dart';
import 'package:app/components/loading_dialog.dart';
import 'package:app/constants/colors.dart';
import 'package:app/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/components/login_page/rounded_input_field.dart';
import 'package:app/components/login_page/rounded_password_field.dart';
import 'package:app/components/underlined_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // [1]: isChanged, [2]: isValid
  Map<String, dynamic> form = {
    "userName": [TextEditingController(), false, false],
    "password": [TextEditingController(), false, false],
    "id": [TextEditingController(), false, false],
    "email": [TextEditingController(), false, false],
    "unit": [TextEditingController(), false, false],
    "rank": [TextEditingController(), false, false],
  };
  ImagePicker imagePicker = ImagePicker();

  File? _image;

  var myId = 'testID';
  late int _registerResponse;
  late User myUser;

  // final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    form.forEach((key, value) {
      value[0].dispose();
    });
    super.dispose();
  }

  void handleSubmit() async {

  myShowDialog(context, "회원가입중입니다..");
    _registerResponse = await createUser(
      form["userName"][0].value.text,
      form["id"][0].value.text,
      form["password"][0].value.text,
      form["email"][0].value.text,
      form["unit"][0].value.text,
      form["rank"][0].value.text,
    );

    if (_registerResponse == 200) {
      final snackbar = SnackBar(content: Text('회원가입에 성공했습니다.'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      Navigator.of(context).pushNamed(
        '/home',
        arguments: User(
          form["userName"][0].value.text,
          form["id"][0].value.text,
          form["password"][0].value.text,
          form["email"][0].value.text,
          form["unit"][0].value.text,
          form["rank"][0].value.text,
        ),
      );
    } else {
      final snackbar =
          SnackBar(content: Text('회원가입에 실패했습니다. 에러코드 : ${_registerResponse}'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<bool> rankValidator(String value) async {
    bool flag = false;
    for (var e in rankList) {
      if (value == e) {
        flag = true;
      }
    }
    return flag;
  }

  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.08),
                  UnderLinedText(
                      text: "내 손안의 진중문고",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      thickness: 7),
                  SizedBox(height: size.height * 0.03),
                  InkWell(
                      onTap: _onCameraClick,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          _image != null
                              ? CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 190,
                                      height: 190,
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : DefaultCircleAvatar(size: 100),
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
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "성명",
                    controller: form["userName"][0],
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  RoundedInputField(
                    hintText: "아이디",
                    controller: form["id"][0],
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  RoundedPasswordField(
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      node.unfocus();
                    },
                    controller: form["password"][0],
                  ),
                  
                  RoundedInputField(
                      hintText: "이메일",
                      controller: form["email"][0],
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      onChanged: (value) => {
                            setState(() {
                              form["email"][1] = true;
                              form["email"][2] = EmailValidator.validate(value);
                            }),
                          },
                      icon: Icons.email),
                  Visibility(
                      visible: form["email"][1],
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
                          child: Text(
                            form["email"][2] ? '이메일이 적절합니다.' : '이메일이 부적절합니다.',
                            style: TextStyle(
                                fontSize: 14,
                                color: (form["email"][2]
                                    ? Colors.green.withOpacity(0.8)
                                    : Colors.red.withOpacity(0.8))),
                          ),
                        ),
                      )),
                  RoundedInputField(
                      hintText: "소속 부대",
                      controller: form["unit"][0],
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => node.nextFocus(),
                      icon: Icons.group),
                  RoundedInputField(
                      hintText: "계급",
                      controller: form["rank"][0],
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () =>
                          {FocusScope.of(context).unfocus()},
                      onChanged: (value) => {
                            setState(() {
                              form["rank"][1] = true;
                              rankValidator(value)
                                  .then((value) => form["rank"][2] = value);
                            }),
                          },
                      icon: Icons.military_tech),
                  Visibility(
                      visible: form["rank"][1],
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
                          child: Text(
                            form["rank"][2] ? '계급이 적절합니다.' : '계급이 부적절합니다.',
                            style: TextStyle(
                                fontSize: 14,
                                color: (form["rank"][2]
                                    ? Colors.green.withOpacity(0.8)
                                    : Colors.red.withOpacity(0.8))),
                          ),
                        ),
                      )),
                  RoundedButton(
                    text: "회원가입",
                    press: handleSubmit,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "회원이신가요?  ",
                        style: TextStyle(color: Color(COLOR_PRIMARY)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        // onTap: _onCameraClick,
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            color: Color(COLOR_PRIMARY),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            )));
  }

  _onCameraClick() async {
    ImagePicker _imagePicker = imagePicker;
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (image != null) {
      prefs.setString('profileImage', image.path);

      setState(() {
        _image = File(image.path);
      });
    }
  }
}
