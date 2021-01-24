import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/skeleton.dart';

import '../../models/Lottery.model.dart';

class LotteryComponent extends StatelessWidget {
  final Future<Lottery> lottery;
  final int lotteryNo;
  final bool activeLogo;
  final String title;

  LotteryComponent(
      {Key key,
      @required this.lottery,
      @required this.lotteryNo,
      this.activeLogo,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lottery>(
      future: lottery,
      builder: (BuildContext context, AsyncSnapshot snapshot) {


        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return gameViewer(snapshot);
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
        break;
    }
    return color;
  }

  Widget gameViewer(AsyncSnapshot snapshot) {
    bool hasData = snapshot.hasData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        activeLogo == false
            ? Container(
                alignment: Alignment.centerRight,
                child: Container(
                    width: ScreenUtil().setWidth(68),
                    height: ScreenUtil().setWidth(68),
                    child: Image.asset('assets/images/logo.png')),
              )
            : null,
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(18),
              bottom: ScreenUtil().setHeight(23)),
          child: Row(
            children: <Widget>[
              hasData
                  ? Container(
                      width: ScreenUtil().setWidth(156),
                      height: ScreenUtil().setHeight(40),
                      child: Text(
                        title == null ? '$lotteryNo회 당첨번호' : title,
                        style: TextStyle(
                            letterSpacing: ScreenUtil().setWidth(-0.36),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SpoqaHanSans',
                            fontSize: ScreenUtil().setSp(24)),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Skeleton(
                      width: 156,
                      height: 37,
                      type: EnumType.CIRCLE,
                    ),
            ],
          ),
        ),
        Container(
          child: matchingRound(snapshot),
        ),
      ].where((Object o) => o != null).toList(),
    );
  }

  Widget matchingRound(AsyncSnapshot snapshot) {
    bool hasData = snapshot.hasData;
    Lottery lottery = snapshot.data;
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(3), right: ScreenUtil().setWidth(2)),
      child: hasData
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                lotteryNumberItem(lottery.drwtNo1),
                lotteryNumberItem(lottery.drwtNo2),
                lotteryNumberItem(lottery.drwtNo3),
                lotteryNumberItem(lottery.drwtNo4),
                lotteryNumberItem(lottery.drwtNo5),
                lotteryNumberItem(lottery.drwtNo6),
                Container(
                  child: Icon(
                    FontAwesome.plus,
                    size: ScreenUtil().setWidth(12),
                  ),
                ),
                lotteryNumberItem(lottery.bnusNo),
              ],
            )
          : Skeleton(width: 375, height: 40, type: EnumType.CIRCLE),
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
