import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/myLottery/lotteryResult.dart';
import 'package:lottery/models/Lottery.dart';
import 'package:lottery/models/MyLotteryList.dart';
import 'package:lottery/services/lotteryService.dart';

class LotteryScreen extends StatefulWidget {
  final int drwNo;

  LotteryScreen({Key key, @required this.drwNo}) : super(key: key);

  @override
  _LotteryScreenState createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  Future<List<MyLotteryList>> myLotteryList;
  Future<Lottery> lottery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myLotteryList = fetchMyLottery(widget.drwNo);
    lottery = fetchLottery(widget.drwNo);
  }

  void carouselCallback(int index, dynamic reason) {
    print('$index : $reason');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(68, 59, 201, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(68, 59, 201, 1),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, index) {
            ScreenUtil.init(context, width: 550, height: 1334);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(550),
                  height: ScreenUtil().setHeight(850),
                  child: LotteryResult(
                    myLotteryList: myLotteryList,
                    lottery: lottery,
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(child: Text('광고넣을거지롱')),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
