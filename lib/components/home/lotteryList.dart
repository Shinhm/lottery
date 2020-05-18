import 'dart:ui';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/screens/LotteryScreen.dart';
import 'package:lottery/services/lotteryService.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class LotteryList extends StatefulWidget {
  final int drwNo;

  LotteryList({Key key, @required this.drwNo}) : super(key: key);

  @override
  _LotteryListState createState() => _LotteryListState();
}

class _LotteryListState extends State<LotteryList> {
  Future<List<MyLotteryListModel>> lotteryListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      lotteryListModel = fetchMyLotteryList();
    });
  }

  void scannerOpen() async {
    var result = await BarcodeScanner.scan(
        options: ScanOptions(strings: {
      "cancel": "취소",
      "flash_on": "플래쉬 켜기",
      "flash_off": "플래쉬 끄기",
    }, useCamera: 0));
    var numbers = new List<int>();
    RegExp regExp = new RegExp(
      r"/m.dhlottery.co.kr/",
      caseSensitive: false,
      multiLine: false,
    );
    RegExp matchNumber = new RegExp(
      r"\d+",
      multiLine: true,
    );
    if (!regExp.hasMatch(result.rawContent)) {
      return;
    }
    http.Response response = await http.get(
        'https://m.dhlottery.co.kr/qr.do?method=winQr&v=${result.rawContent.split('v=')[1]}');
    dom.Document document = parser.parse(response.body);
    String drwTitle = document.getElementsByClassName("key_clr1").first.text;
    int drwNo = int.parse(matchNumber.stringMatch(drwTitle));
    document
        .getElementsByClassName("tbl_basic")
        .first
        .getElementsByClassName("clr")
        .map((span) {
      numbers.add(int.parse(span.text));
      if (numbers.length == 6) {
        print(numbers);
        MyLotteryListModel lottery = MyLotteryListModel(
            drwNo: drwNo,
            num1: numbers[0],
            num2: numbers[1],
            num3: numbers[2],
            num4: numbers[3],
            num5: numbers[4],
            num6: numbers[5]);
        addLotteryNumbers(lottery).then((value) => {
              setState(() {
                lotteryListModel = fetchMyLotteryList();
              })
            });
        numbers.clear();
      }
    }).toList();
  }

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
          child: FutureBuilder(
            future: lotteryListModel,
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
                  onTap: () => scannerOpen(),
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
          MyLotteryListModel lottery = myLotteryList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LotteryScreen(drwNo: lottery.drwNo)));
            },
            child: Slidable(
              actionPane: SlidableBehindActionPane(),
              actionExtentRatio: 0.2,
              fastThreshold: 0.2,
              secondaryActions: <Widget>[
                IconSlideAction(
                  color: Color.fromRGBO(238, 69, 82, 1),
                  icon: Icons.delete,
                  onTap: () {
                    deleteLotteryNumbers(lottery.id);
                    setState(() {
                      lotteryListModel = fetchMyLotteryList();
                    });
                  },
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(219, 218, 216, 1),
                            width: 1))),
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(17.5),
                    bottom: ScreenUtil().setSp(16.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "${lottery.drwNo}회",
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
              ),
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
