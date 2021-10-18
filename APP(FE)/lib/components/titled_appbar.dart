import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

AppBar TitledAppbar(String title) {
  return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
          child: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ))),
      backgroundColor: const Color(COLOR_PRIMARY),
      elevation: 0.5);
}

// AppBar TitledAppbar(String title){
//   return AppBar(
//             automaticallyImplyLeading: false,
//             title: Center(
//                 child: Text(title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       // fontWeight: FontWeight.bold,
//                     ))),
//             backgroundColor: const Color(COLOR_PRIMARY),
//             elevation: 0.5);
// }