import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/screens/LotteryScreen.dart';
import 'package:lottery/services/lotteryService.dart';

class LotteryList extends StatefulWidget {
  final int drwNo;
  final VoidCallback callBarcodeScanner;

  LotteryList({Key key, @required this.drwNo, this.callBarcodeScanner})
      : super(key: key);

  @override
  _LotteryListState createState() => _LotteryListState();
}

class _LotteryListState extends State<LotteryList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(23),
              bottom: ScreenUtil().setHeight(16)),
          child: Divider(
            color: Color.fromRGBO(31, 26, 29, 1),
            thickness: ScreenUtil().setHeight(3),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
          width: ScreenUtil().setWidth(375),
          height: ScreenUtil().setHeight(37),
          child: Text(
            '내 번호',
            style: TextStyle(
                letterSpacing: ScreenUtil().setSp(-0.36),
                fontWeight: FontWeight.bold,
                fontFamily: 'SpoqaHanSans',
                fontSize: ScreenUtil().setSp(24)),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(375),
          height: ScreenUtil().setHeight(368),
          child: FutureBuilder<List<MyLotteryListModel>>(
            future: fetchMyLotteryList(),
            builder: (context, snapshot) {
              var hasData = snapshot.hasData;
              var data = snapshot.data;
              var hasError = snapshot.hasError;
              var error = snapshot.error;
              if (hasData) {
                if (data.length == 0) {
                  return emptyMyList;
                }
                return myLotteryList(data, context);
              } else if (hasError) {
                return Text("$error");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Stack(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(375),
              height: ScreenUtil().setHeight(56),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: ScreenUtil().setWidth(375),
                height: ScreenUtil().setHeight(56),
                child: Divider(
                  color: Color.fromRGBO(31, 26, 29, 1),
                  thickness: ScreenUtil().setHeight(3),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(135)),
                child: InkWell(
                  onTap: () => widget.callBarcodeScanner(),
                  child: Container(
                    width: ScreenUtil().setWidth(56),
                    height: ScreenUtil().setWidth(56),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(31, 26, 29, 1),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(56))),
                    child: Icon(
                      FontAwesome.plus,
                      color: Color.fromRGBO(238, 69, 82, 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget myLotteryList(List<MyLotteryListModel> myLotteryList, context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(17)),
        itemCount: myLotteryList.length,
        itemBuilder: (context, index) {
          var lottery = myLotteryList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LotteryScreen(drwNo: myLotteryList[index].drwNo)));
            },
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${myLotteryList[index].drwNo}회",
                        style: TextStyle(
                            color: Color.fromRGBO(121, 116, 121, 1),
                            fontSize: ScreenUtil().setSp(14),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(193),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num1),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num2),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num3),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num4),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num5),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(219, 218, 216, 1),
                              lotteryNumber: lottery.num6),
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(FontAwesome.angle_right),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(17.5),
                      bottom: ScreenUtil().setSp(16.5)),
                  child: Divider(
                    thickness: ScreenUtil().setHeight(1),
                    color: Color.fromRGBO(219, 218, 216, 1),
                  ),
                )
              ],
            ),
          );
        });
  }
}

var emptyMyList = Center(
    child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Container(
        height: 100,
        child: Icon(
          Icons.inbox,
          size: ScreenUtil().setSp(50),
          color: Color.fromRGBO(31, 26, 29, 1),
        )),
    Text(
      '등록된 로또번호가 없습니다.',
      style: TextStyle(
          fontSize: ScreenUtil().setSp(19),
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(31, 26, 29, 1)),
    ),
    Text(
      '아래 버튼을 클릭하여 등록해주세요.',
      style: TextStyle(
          fontSize: ScreenUtil().setSp(19),
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(31, 26, 29, 1)),
    ),
  ],
));
