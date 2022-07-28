import 'package:flutter/material.dart';
import 'package:games_bk/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Games',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Teko',
      ),
      home: const HomePage(title: 'Flutter Games'),
    );
  }
}
