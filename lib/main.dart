import 'package:flutter/material.dart';
import 'package:spring_ecommerce_app/globals/global_and_constants.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: kPrimaryColor,
          centerTitle: true,
        ),
        accentColor: kAccentColor,
        backgroundColor: const Color(0xFFEAFDFC),
        scaffoldBackgroundColor: const Color(0xFFEAFDFC),
      ),
      home: const HomeScreen(),
    );
  }
}
