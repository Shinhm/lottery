import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/Lottery.dart';

class LotteryComponent extends StatelessWidget {
  final Future<Lottery> lottery;
  final int lotteryNo;

  LotteryComponent({Key key, @required this.lottery, @required this.lotteryNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lottery>(
      future: lottery,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return gameViewer(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Color colorMaker(int lotteryNumber) {
    Color color;
    switch ((lotteryNumber - 1) ~/ 10) {
      case 0:
        color = Colors.yellow;
        break;
      case 1:
        color = Colors.blue;
        break;
      case 2:
        color = Colors.red;
        break;
      case 3:
        color = Colors.black54;
        break;
      case 4:
        color = Colors.green;
        break;
    }
    return color;
  }

  Widget gameViewer(Lottery lottery) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setSp(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setSp(70), bottom: ScreenUtil().setSp(40)),
            child: Container(
              child: Text(
                '$lotteryNo회차 로또번호',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: ScreenUtil().setSp(40)),
              ),
            ),
          ),
          Container(
            child: matchingRound(lottery),
          ),
        ],
      ),
    );
  }

  Widget matchingRound(Lottery lottery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num1}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num1),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num2}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num2),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num3}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num3),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num4}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num4),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num5}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num5),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(70),
          height: ScreenUtil().setHeight(130),
          child: Center(
            child: Text(
              "${lottery.num6}",
              style: TextStyle(
                  color: Color.fromRGBO(68, 59, 201, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          ),
          decoration: BoxDecoration(
            color: colorMaker(lottery.num6),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ],
    );
  }
}
