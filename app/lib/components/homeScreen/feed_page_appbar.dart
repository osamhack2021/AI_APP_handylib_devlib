import 'package:app/components/homeScreen/search_modal_bottom_sheet.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// AppBar FeedPageAppBar(BuildContext context) {
//   return AppBar(
//     backgroundColor: Color(COLOR_PRIMARY2),
//     elevation: 0.5,
//     title: const Center(
//       child: Image(
//         image: AssetImage('assets/images/logo.png'),
//         width: 100,
//         height: 100,
//       ),
//     ),
//     leading: IconButton(
//       padding: const EdgeInsets.only(left: 30.0),
//       onPressed: () => print('Menu'),
//       icon: const Icon(Icons.menu),
//       iconSize: 30.0,
//       color: const Color(COLOR_PRIMARY),
//     ),
//     // leading: const SizedBox(
//     //   width: 100,
//     //   height: 100,
//     // ),
//     actions: <Widget>[
//       IconButton(
//         padding: const EdgeInsets.only(right: 30.0),
//         onPressed: () => showCupertinoModalBottomSheet(
//           expand: true,
//           context: context,
//           backgroundColor: Colors.transparent,
//           builder: (context) => SearchModalBottomSheet(),
//         ),
//         icon: const Icon(Icons.search),
//         iconSize: 30.0,
//         color: const Color(COLOR_PRIMARY),
//       ),
//     ],
//   );
// }

AppBar FeedPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(COLOR_PRIMARY),
    elevation: 0.5,
    title: const Center(
      child: Image(
        image: AssetImage('assets/images/logo.ico'),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        color: Color(COLOR_PRIMARY2),
      ),
    ),
    // leading: IconButton(
    //   padding: const EdgeInsets.only(left: 30.0),
    //   onPressed: () => print('Menu'),
    //   icon: const Icon(Icons.menu),
    //   iconSize: 30.0,
    //   color: Colors.white,
    // ),
    // leading: const SizedBox(
    //   width: 100,
    //   height: 100,
    // ),
    actions: <Widget>[
      IconButton(
        padding: const EdgeInsets.only(right: 30.0),
        onPressed: () => showCupertinoModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => SearchModalBottomSheet(),
        ),
        icon: const Icon(Icons.search),
        iconSize: 30.0,
        color: Colors.white,
      ),
    ],
  );
}
