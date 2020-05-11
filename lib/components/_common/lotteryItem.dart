import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LotteryItem extends StatelessWidget {
  final int lotteryNumber;
  final Color backgroundColor;
  final Color fontColor;
  final bool active;

  LotteryItem(
      {Key key,
      @required this.lotteryNumber,
      this.backgroundColor,
      this.fontColor,
      this.active})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(30),
      height: ScreenUtil().setWidth(30),
      child: Center(
        child: Text(
          "$lotteryNumber",
          style: TextStyle(
            fontFamily: 'SpoqaHanSans',
              color: active
                  ? Color.fromRGBO(68, 59, 201, 1)
                  : Color.fromRGBO(31, 26, 29, 1),
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(14)),
        ),
      ),
      decoration: BoxDecoration(
          color: active
              ? colorMaker(lotteryNumber)
              : backgroundColor != null
                  ? backgroundColor
                  : Color.fromRGBO(244, 245, 252, 1),
          borderRadius: BorderRadius.circular(ScreenUtil().setSp(30))),
    );
  }
}
