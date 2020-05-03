import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/myLottery/lotteryResult.dart';
import 'package:lottery/models/Lottery.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
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
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, index) {
            ScreenUtil.init(context, width: 550, height: 1334);
            return Container(
              width: ScreenUtil().setWidth(550),
              height: ScreenUtil().setHeight(1334),
              child: LotteryResult(
                myLotteryList: myLotteryList,
                lottery: lottery,
              ),
            );
          },
        ),
      ),
    );
  }
}
