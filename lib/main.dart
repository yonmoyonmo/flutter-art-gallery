import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mom's Art Gallery",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[300],
        accentColor: Colors.grey[400],
        fontFamily: 'Fondamento',
      ),
      home: HomePage(),
    );
  }
}
