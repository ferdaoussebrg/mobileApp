import 'package:flutter/material.dart';
import 'package:fairyapp/pages/home.page.dart';
import 'package:fairyapp/pages/calculs.page.dart';
import 'package:fairyapp/pages/ui.page.dart';
import 'package:fairyapp/pages/weather.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP flutter',
      routes: {
        "/": (context) => HomePage(),
        "/calcus": (context) => CalculsPage(),
        "/ui": (context) => UIPage(),
        "/weather": (context) => Weather(),
      },
      initialRoute: "/",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}