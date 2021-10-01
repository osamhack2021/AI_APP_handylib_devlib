import 'package:app/controller/user_controller.dart';
import 'package:app/pages/setting_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future<dynamic> showModifyDialog(BuildContext context, String? text) {
    return showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                title:Text("${getPropertyTitle(myUser!,text!)} 수정"),
                content:
                  TextFormField(
                    onSaved:(String? _value){},
                    validator:(_value){
                    },
                    controller: modifySettingController,
                  ),
                  actions: <Widget>[
                    Center(
                      child: TextButton(
                          onPressed: (){
                            text ='hello';
                            final snackbar = SnackBar(content:Text('변경에 실패했습니다.'));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
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