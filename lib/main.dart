import 'package:flutter/material.dart';
import 'package:lottery/screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'lottery-app', home: HomeScreen());
  }
}