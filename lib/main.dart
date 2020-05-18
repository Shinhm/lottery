import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottery/screens/HomeScreen.dart';
import 'package:lottery/screens/MapScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'lottery-app',
      home: PageScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Color.fromRGBO(236, 234, 234, 1),
        secondaryHeaderColor: Color.fromRGBO(236, 234, 234, 1),
        backgroundColor: Color.fromRGBO(236, 234, 234, 1),
        primaryColor: Color.fromRGBO(236, 234, 234, 1),
        scaffoldBackgroundColor: Color.fromRGBO(236, 234, 234, 1),
        canvasColor: Color.fromRGBO(236, 234, 234, 1),
        // Define the default font family.
        fontFamily: 'SpoqaHanSans',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
    );
  }
}

class PageScreen extends StatefulWidget {
  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  PageController _controller = PageController(
    initialPage: 1,
  );
  int lotteryNo;

  void jumpToHomeScreen() {
    _controller.jumpToPage(1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final birthday = DateTime(2002, 12, 07, 20, 00);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final drwNo = (difference ~/ 7) + 1;
    lotteryNo = drwNo;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        MapScreen(
          drwNo: lotteryNo,
        ),
        HomeScreen(),
      ],
    );
  }
}
