import 'package:app/constants/size.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/pages/setting_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class _ModifyContent extends StatefulWidget {
  String title;
  Function()? callback;
  _ModifyContent({Key? key, required this.title, this.callback}) : super(key: key);

  @override
  __ModifyContentState createState() => __ModifyContentState();
}

class __ModifyContentState extends State<_ModifyContent> {
  bool _isValid = false;
  bool _isChanged = false;

  Future<bool> RankValidator(String value) async {
    bool flag = false;
    rankList.forEach((element) {
      if (value == element) {
        flag = true;
      }
    });
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("${getPropertyTitle(myUser!, this.widget.title)} 수정"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            onChanged: (value) => {
              setState(() {
                _isChanged = true;
                if (widget.title == "email") {
                  _isValid = EmailValidator.validate(value);
                } else if (widget.title == "rank") {
                  RankValidator(value).then((value) => _isValid = value);
                }
              }),
            },
            onSaved: (String? _value) {},
            validator: (_value) {},
            controller: modifySettingController[widget.title],
          ),
          Visibility(
              visible: _isChanged && widget.title == "rank",
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _isValid ? '계급이 적절합니다.' : '계급이 부적절합니다.',
                    style: TextStyle(
                        fontSize: 14,
                        color: (_isValid
                            ? Colors.green.withOpacity(0.8)
                            : Colors.red.withOpacity(0.8))),
                  ),
                ),
              )),
          Visibility(
              visible: _isChanged && widget.title == "email",
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _isValid ? '이메일이 적절합니다.' : '이메일이 부적절합니다.',
                    style: TextStyle(
                        fontSize: 14,
                        color: (_isValid
                            ? Colors.green.withOpacity(0.8)
                            : Colors.red.withOpacity(0.8))),
                  ),
                ),
              ))
        ]),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () async {
                User newUserInfo;
                newUserInfo = userCopy(myUser!);
                if (widget.title == 'email') {
                  newUserInfo.email =
                      modifySettingController[widget.title]!.value.text;
                } else if (widget.title == 'unit') {
                  newUserInfo.unit =
                      modifySettingController[widget.title]!.value.text;
                } else if (widget.title == 'rank') {
                  newUserInfo.rank =
                      modifySettingController[widget.title]!.value.text;
                } else {
                  debugPrint('잘못된 title값이 전달되었습니다. show_modify_dialog');
                  Navigator.pop(context);
                  final snackbar =
                      SnackBar(content: Text('변경에 실패했습니다 : 잘못된 title값 전달'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
                int res = await modifyUserInfo(newUserInfo);
                if (res == 200) {
                  final snackbar = SnackBar(content: Text('변경하였습니다.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);

                  myUser = userCopy(newUserInfo);
                  widget.callback!();
                  Navigator.pop(context);
                } else {
                  debugPrint('변경에 실패했습니다. ${res}');
                  final snackbar =
                      SnackBar(content: Text('변경에 실패했습니다 : ${res.toString()}'));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  Navigator.pop(context);
                }

                /*final snackbar = SnackBar(content: Text('변경에 실패했습니다.'));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.pop(context);*/
              },
              child: const Text('변경'),
            ),
          ),
        ]);
  }
}

Future<dynamic> showModifyDialog(BuildContext context, String? title,Function() callback) {
  
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ModifyContent(title: title!,callback:callback);
      });
}
