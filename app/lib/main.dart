import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/navigation/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  await dotenv.load(fileName: "setting.env");
  initializeDateFormatting('ko_KR', null).then((_) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
