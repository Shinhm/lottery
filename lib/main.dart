import 'package:flutter/material.dart';
import 'package:lottery/screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'lottery-app',
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(68, 59, 201, 1),
        accentColor: Colors.cyan[600],
        scaffoldBackgroundColor: Color.fromRGBO(68, 59, 201, 1),
        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
