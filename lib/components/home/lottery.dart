import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/Lottery.model.dart';

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
        color = Color.fromRGBO(246, 192, 84, 1);
        break;
      case 1:
        color = Color.fromRGBO(164, 107, 235, 1);
        break;
      case 2:
        color = Color.fromRGBO(252, 153, 187, 1);
        break;
      case 3:
        color = Color.fromRGBO(174, 174, 174, 1);
        break;
      case 4:
        color = Color.fromRGBO(246, 192, 84, 1);
        color = Colors.green;
        break;
    }
    return color;
  }

  Widget gameViewer(Lottery lottery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          child: Container(
              width: ScreenUtil().setWidth(68),
              height: ScreenUtil().setWidth(68),
              child: Image.asset('assets/images/logo.png')),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(18),
              bottom: ScreenUtil().setHeight(26)),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(156),
                height: ScreenUtil().setHeight(36),
                child: Text(
                  '$lotteryNo회 당첨번호',
                  style: TextStyle(
                    letterSpacing: ScreenUtil().setWidth(-0.36),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SpoqaHanSans',
                      fontSize: ScreenUtil().setSp(24)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: matchingRound(lottery),
        ),
      ],
    );
  }

  Widget matchingRound(Lottery lottery) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          lotteryNumberItem(lottery.num1),
          lotteryNumberItem(lottery.num2),
          lotteryNumberItem(lottery.num3),
          lotteryNumberItem(lottery.num4),
          lotteryNumberItem(lottery.num5),
          lotteryNumberItem(lottery.num6),
          Container(
            child: Icon(
              FontAwesome.plus,
              size: ScreenUtil().setWidth(12),
            ),
          ),
          lotteryNumberItem(lottery.bonusNum),
        ],
      ),
    );
  }

  Widget lotteryNumberItem(int num) {
    return Container(
      width: ScreenUtil().setWidth(40),
      height: ScreenUtil().setWidth(40),
      child: Center(
        child: Text(
          "$num",
          style: TextStyle(
              color: Color.fromRGBO(31, 26, 29, 1),
              letterSpacing: ScreenUtil().setSp(-0.27),
              fontWeight: FontWeight.bold,
              fontFamily: 'SpoqaHanSans',
              fontSize: ScreenUtil().setSp(18)),
        ),
      ),
      decoration: BoxDecoration(
        color: colorMaker(num),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(40)),
      ),
    );
  }
}
