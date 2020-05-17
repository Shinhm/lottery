import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/home/lottery.dart';
import 'package:lottery/components/home/lotteryList.dart';
import 'package:lottery/models/Lottery.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/services/lotteryService.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _numberOfCameras = 0;

  void main() async {
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
    print(!regExp.hasMatch(result.rawContent));
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
        MyLotteryListModel lottery = MyLotteryListModel(0, drwNo, numbers[0],
            numbers[1], numbers[2], numbers[3], numbers[4], numbers[5]);
        addLotteryNumbers(lottery);
        numbers.clear();
      }
    }).toList();
  }

  Future<Lottery> lottery;
  int lotteryNo;

  @override
  void initState() {
    super.initState();
    final birthday = DateTime(2002, 12, 07, 20, 50);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final drwNo = (difference ~/ 7) + 1;
    print(drwNo);
    () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      print(_numberOfCameras);
    }();
    lotteryNo = drwNo;
    lottery = fetchLottery(drwNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        ScreenUtil.init(context, width: 375, height: 812);
        return Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(32),
              right: ScreenUtil().setWidth(24),
              left: ScreenUtil().setWidth(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Container(
                    child: LotteryComponent(
                  activeLogo: false,
                  lottery: lottery,
                  lotteryNo: lotteryNo,
                )),
              ),
              Container(
                width: ScreenUtil().setWidth(375),
                child: LotteryList(drwNo: lotteryNo, callBarcodeScanner: main),
              )
            ],
          ),
        );
      }),
    );
  }
}
