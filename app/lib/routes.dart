import 'package:app/pages/feed_page.dart';
import 'package:app/pages/lib_page.dart';
import 'package:app/pages/mybook_page.dart';
import 'package:app/pages/setting_page.dart';
import 'package:flutter/material.dart';

import 'package:app/screens/home_screen.dart';
import 'package:app/screens/auth_screen.dart';
import 'package:app/screens/onboard_screen.dart';
import 'package:app/pages/login_page.dart';

final routes = {
  '/onboard': (BuildContext context) => OnboardScreen(),
  '/auth': (BuildContext context) => AuthScreen(),
  '/home': (BuildContext context) => HomeScreen(),
};

final homeRoute = [
  Feedpage(), // 전자 도서관
  MyBookPage(), // 나의 서재
  LibPage(), // 대대 도서관
  SettingPage() // 개인정보 수정
];
