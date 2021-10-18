import 'package:app/components/underlined_text.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

void myShowDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 200,
                child: Center(
                    child: SizedBox(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(COLOR_PRIMARY)),
                      strokeWidth: 5.0),
                  height: 50.0,
                  width: 50.0,
                )),
              ),
              UnderLinedText(
                text: message,
                thickness: 4,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              )
            ],
          ));
    },
  );
}

void disposeMyDialog(BuildContext context) {
  Navigator.of(context).pop();
}
