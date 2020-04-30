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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(55),
      height: ScreenUtil().setHeight(85),
      child: Center(
        child: Text(
          "$lotteryNumber",
          style: TextStyle(
              color: fontColor != null
                  ? fontColor
                  : Color.fromRGBO(78, 80, 135, 1),
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(25)),
        ),
      ),
      decoration: BoxDecoration(
          color: active
              ? Color.fromRGBO(255, 90, 89, 1)
              : backgroundColor != null
                  ? backgroundColor
                  : Color.fromRGBO(244, 245, 252, 1),
          borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(8),
    );
  }
}
