import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/home/lottery.dart';
import 'package:lottery/components/home/lotteryList.dart';
import 'package:lottery/models/Lottery.dart';
import 'package:lottery/services/lotteryService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void main() async {
    var result = await BarcodeScanner.scan();

    print(result.type); // The result type (barcode, cancelled, failed)
    print(result.rawContent); // The barcode content
    print(result.format); // The barcode format (as enum)
    print(result
        .formatNote); // If a unknown format was scanned this field contains a note
  }

  Future<Lottery> lottery;
  int lotteryNo;

  @override
  void initState() {
    super.initState();
    final birthday = DateTime(2002, 12, 07, 20, 00);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final drwNo = (difference ~/ 7) + 1;
    lotteryNo = drwNo;
    lottery = fetchLottery(drwNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 59, 201, 1),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        ScreenUtil.init(context, width: 550, height: 1334);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(550),
              height: ScreenUtil().setHeight(634),
              child: Center(
                  child: Container(
                      child: LotteryComponent(
                lottery: lottery,
                lotteryNo: lotteryNo,
              ))),
            ),
            Container(
              width: ScreenUtil().setWidth(550),
              height: ScreenUtil().setHeight(700),
              child: LotteryList(),
            )
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Color.fromRGBO(62, 52, 181, 1),
        onPressed: () {
          main();
        },
      ),
    );
  }
}
