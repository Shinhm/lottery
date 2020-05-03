import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/screens/LotteryScreen.dart';
import 'package:lottery/screens/MapScreen.dart';
import 'package:lottery/services/lotteryService.dart';

class LotteryList extends StatefulWidget {
  final int drwNo;

  LotteryList({Key key, @required this.drwNo}) : super(key: key);

  @override
  _LotteryListState createState() => _LotteryListState();
}

class _LotteryListState extends State<LotteryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: ScreenUtil().setSp(40),
          left: ScreenUtil().setSp(40),
          top: ScreenUtil().setSp(20)),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapScreen(drwNo: widget.drwNo,)));
                },
                child: Icon(
                  FontAwesome.map_o,
                  color: Color.fromRGBO(100, 92, 195, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(30)),
                child: Icon(
                  FontAwesome.list_ul,
                  color: Color.fromRGBO(100, 92, 195, 1),
                ),
              ),
            ],
          ),
          FutureBuilder<List<MyLotteryList>>(
            future: fetchMyLotteryList(),
            builder: (context, snapshot) {
              var hasData = snapshot.hasData;
              var data = snapshot.data;
              var hasError = snapshot.hasError;
              var error = snapshot.error;
              if (hasData) {
                return myLotteryList(data, context);
              } else if (hasError) {
                return Text("$error");
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget myLotteryList(List<MyLotteryList> myLotteryList, context) {
    return Container(
      width: ScreenUtil().setWidth(500),
      height: ScreenUtil().setHeight(550),
      child: ListView.builder(
          itemCount: myLotteryList.length,
          itemBuilder: (context, index) {
            var lottery = myLotteryList[index].lotteryNumbers;
            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LotteryScreen(
                              drwNo: myLotteryList[index].drwNo)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${myLotteryList[index].drwNo}회차",
                        style: TextStyle(
                            color: Color.fromRGBO(160, 152, 217, 1),
                            fontSize: ScreenUtil().setSp(23),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num1),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num2),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num3),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num4),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num5),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.num6),
                          Container(
                            width: ScreenUtil().setWidth(40),
                            height: ScreenUtil().setHeight(85),
                            child: Icon(
                              Icons.add,
                              color: Color.fromRGBO(78, 80, 135, 1),
                            ),
                          ),
                          LotteryItem(
                              active: false,
                              backgroundColor: Color.fromRGBO(100, 92, 195, 1),
                              lotteryNumber: lottery.bnusNum),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
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
          size: ScreenUtil().setSp(70),
          color: Color.fromRGBO(68, 59, 201, .8),
        )),
    Text(
      '등록된 로또번호가 없습니다.',
      style: TextStyle(
          fontSize: ScreenUtil().setSp(20),
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(68, 59, 201, .8)),
    ),
    Text(
      '아래 버튼을 클릭하여 등록해주세요.',
      style: TextStyle(
          fontSize: ScreenUtil().setSp(20),
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(68, 59, 201, .8)),
    ),
  ],
));
