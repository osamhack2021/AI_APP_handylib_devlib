import 'package:app/pages/feed_page.dart';
import 'package:app/pages/lib_page.dart';
import 'package:app/pages/mybook_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/pages/setting_page.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/onboard_screen.dart';
import 'package:app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/forum_screen.dart';

final routes = {
  '/onboard': (BuildContext context) => OnboardScreen(),
  '/auth/login': (BuildContext context) => LoginPage(),
  '/auth/register': (BuildContext context) => RegisterPage(),
  '/home': (BuildContext context) => HomeScreen(),
  // '/home/feed': (BuildContext context) => FeedPage(),
  // '/home/mybook': (BuildContext context) => MyBookPage(),
  // '/home/lib': (BuildContext context) => LibPage(),
  // '/home/setting': (BuildContext context) => SettingPage(),
};

final homeRoute = [
  FeedPage(), // 전자 도서관
  MyBookPage(), // 나의 서재
  LibPage(), // 대대 도서관
  ForumScreen(), //게시판
  SettingPage() // 개인정보 수정
];
