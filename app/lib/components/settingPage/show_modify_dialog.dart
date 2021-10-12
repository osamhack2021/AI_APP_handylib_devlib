import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/pages/setting_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';

TextEditingController _modifySettingController = TextEditingController();

Future<dynamic> showModifyDialog(BuildContext context, String? title) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title:Text("${getPropertyTitle(myUser!,title!)} 수정"),
          content:
            TextFormField(
              onSaved:(String? _value){},
              validator:(_value){
              },
              controller: _modifySettingController,
            ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () async{
                  User? newUserInfo = myUser;
                  if(_modifySettingController.value.text == null) {
                    final snackbar = SnackBar(content:Text('공백으로는 변경할 수 없습니다.'));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);  
                  }
                  if(title=="username") {
                    newUserInfo!.username = _modifySettingController.value.text;
                  }
                  else if(title == "password") {
                    final _encryptedPassword = Crypt.sha256(_modifySettingController.value.text, salt:mySalt).toString();
                    newUserInfo!.password = _encryptedPassword;
                  }
                  else if(title == "email") {
                    newUserInfo!.email = _modifySettingController.value.text;
                  }
                  else if(title == "unit") {
                    newUserInfo!.unit = _modifySettingController.value.text;
                  }
                  else if(title == "rank") {
                    newUserInfo!.rank = _modifySettingController.value.text;
                  }
                  else {
                    debugPrint("ShowModifyDialog에 title값이 잘못 전달되었습니다.");
                    Navigator.pop(context); 
                  }
                  int _res = await modifyUserInfo(newUserInfo!);

                  if(_res == 200) {
                    final snackbar = SnackBar(content:Text('변경되었습니다.'));
                    myUser = newUserInfo;
                    debugPrint("myUser data was modified in ShowModifyDialog");
                  }
                  else {
                    final snackbar = SnackBar(content:Text('변경에 실패했습니다. 에러코드 : ${_res}'));
                  };
                  Navigator.pop(context); 
                },
                  
                child: const Text('변경'),
                ),
              ),
          ]
        );
      }
    );
}