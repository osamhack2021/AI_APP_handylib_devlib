import 'package:app/components/homeScreen/search_modal_bottom_sheet.dart';
import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

AppBar FeedPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: const Center(
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        width: 100,
        height: 100,
      ),
    ),
    leading: IconButton(
      padding: const EdgeInsets.only(left: 30.0),
      onPressed: () => print('Menu'),
      icon: const Icon(Icons.menu),
      iconSize: 30.0,
      color: const Color(COLOR_PRIMARY),
    ),
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
        color: const Color(COLOR_PRIMARY),
      ),
    ],
  );
}
