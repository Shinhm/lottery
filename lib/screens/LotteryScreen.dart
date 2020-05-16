import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/home/lottery.dart';
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
  Future<List<MyLotteryListModel>> myLotteryList;
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
        title: Text(
          '${widget.drwNo} 회차',
          style: TextStyle(fontSize: ScreenUtil().setSp(17)),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, index) {
          ScreenUtil.init(context, width: 375, height: 812);
          return Column(
            children: <Widget>[
              Container(
                  width: ScreenUtil().setWidth(375),
                  height: ScreenUtil().setHeight(130),
                  padding: EdgeInsets.only(
                      right: ScreenUtil().setWidth(24),
                      left: ScreenUtil().setWidth(24)),
                  child: LotteryComponent(
                    lottery: lottery,
                    lotteryNo: widget.drwNo,
                  )),
              Container(
                width: ScreenUtil().setWidth(375),
                height: ScreenUtil().setHeight(550),
                child: LotteryResult(
                  myLotteryList: myLotteryList,
                  lottery: lottery,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
