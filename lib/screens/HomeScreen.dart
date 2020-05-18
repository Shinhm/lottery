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

  Future<Lottery> lottery;
  int lotteryNo;

  @override
  void initState() {
    super.initState();
    final birthday = DateTime(2002, 12, 07, 20, 50);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final drwNo = (difference ~/ 7) + 1;
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
                child: LotteryList(drwNo: lotteryNo),
              )
            ],
          ),
        );
      }),
    );
  }
}
