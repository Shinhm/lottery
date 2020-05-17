import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/helper/numberFormatHelper.dart';
import 'package:lottery/models/Lottery.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottie/lottie.dart';

class LotteryResult extends StatelessWidget {
  final Future<Lottery> lottery;
  final Future<List<MyLotteryListModel>> myLotteryList;

  const LotteryResult(
      {Key key, @required this.lottery, @required this.myLotteryList})
      : super(key: key);

  int lotteryRank(Lottery winnerNumber, MyLotteryListModel checkNumber) {
    List<bool> returnBool = new List.filled(6, false);

    if (winnerNumber.num1 == checkNumber.num1) {
      returnBool[0] = true;
    }
    if (winnerNumber.num2 == checkNumber.num2) {
      returnBool[1] = true;
    }
    if (winnerNumber.num3 == checkNumber.num3) {
      returnBool[2] = true;
    }
    if (winnerNumber.num4 == checkNumber.num4) {
      returnBool[3] = true;
    }
    if (winnerNumber.num5 == checkNumber.num5) {
      returnBool[4] = true;
    }
    if (winnerNumber.num6 == checkNumber.num6) {
      returnBool[5] = true;
    }

    var lotteryActiveNumberLength =
        returnBool.where((bool) => bool).toList().length;
    if (lotteryActiveNumberLength == 6) return 1;
    if (lotteryActiveNumberLength == 5) {
      return 3;
    }
    if (lotteryActiveNumberLength == 4) return 4;
    if (lotteryActiveNumberLength == 3) return 5;
    return 6;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lottery,
      builder: (BuildContext context, AsyncSnapshot lotterySnapshot) {
        var hasData = lotterySnapshot.hasData;
        Lottery lotteryNo = lotterySnapshot.data;

        if (!hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: myLotteryList,
          builder: (context, snapshot) {
            var hasData = snapshot.hasData;
            List<MyLotteryListModel> data = snapshot.data;

            if (!hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return CarouselSlider.builder(
                options: CarouselOptions(
                  height: ScreenUtil().setHeight(600),
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  var myLottery = data[itemIndex];
                  int rank = lotteryRank(lotteryNo, myLottery);
                  List<LotteryResultModel> lottoResult = lotteryNo.lottoResult;
                  LotteryResultModel rankInfo =
                      new LotteryResultModel('ANY', 0, 0, 0);
                  if (rank < 6) {
                    rankInfo = lottoResult[rank - 1];
                  }
                  return Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: ScreenUtil().setHeight(250),
                          child: rank == 1 || rank == 2
                              ? Lottie.asset('assets/lottie/17664-premium.json',
                                  width: ScreenUtil().setWidth(200))
                              : rank == 6
                                  ? Lottie.asset(
                                      'assets/lottie/7308-empty.json',
                                      width: ScreenUtil().setHeight(200),
                                      height: ScreenUtil().setHeight(200))
                                  : Lottie.asset(
                                      'assets/lottie/4331-coins-money-reward-prize.json',
                                      width: ScreenUtil().setWidth(200)),
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(250),
                        margin: EdgeInsets.only(
                            right: ScreenUtil().setWidth(10),
                            left: ScreenUtil().setWidth(10)),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(31, 26, 29, .3),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: Offset(1, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(236, 234, 234, 1)),
                        child: Container(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(15)),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      LotteryItem(
                                        active:
                                            lotteryNo.num1 == myLottery.num1,
                                        lotteryNumber: myLottery.num1,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                      LotteryItem(
                                        active:
                                            lotteryNo.num2 == myLottery.num2,
                                        lotteryNumber: myLottery.num2,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                      LotteryItem(
                                        active:
                                            lotteryNo.num3 == myLottery.num3,
                                        lotteryNumber: myLottery.num3,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                      LotteryItem(
                                        active:
                                            lotteryNo.num4 == myLottery.num4,
                                        lotteryNumber: myLottery.num4,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                      LotteryItem(
                                        active:
                                            lotteryNo.num5 == myLottery.num5,
                                        lotteryNumber: myLottery.num5,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                      LotteryItem(
                                        active:
                                            lotteryNo.num6 == myLottery.num6,
                                        lotteryNumber: myLottery.num6,
                                        backgroundColor:
                                            Color.fromRGBO(219, 218, 216, 1),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(30)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil().setWidth(60),
                                              child: Lottie.asset(
                                                  'assets/lottie/5166-users-icons.json',
                                                  width:
                                                      ScreenUtil().setWidth(50),
                                                  height: ScreenUtil()
                                                      .setHeight(60)),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil()
                                                      .setWidth(10)),
                                              child: Text(
                                                '${NumberFormatHelper.numberFormat(rankInfo.winningCnt)}',
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(20),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Lottie.asset(
                                                'assets/lottie/16320-piggy-bank-coins-in.json',
                                                width:
                                                    ScreenUtil().setWidth(60),
                                                height:
                                                    ScreenUtil().setHeight(80)),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(25)),
                                                child: Icon(FontAwesome.won)),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setHeight(25)),
                                              child: Text(
                                                '${NumberFormatHelper.numberFormat(rankInfo.winningPriceByRank)}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        ScreenUtil().setSp(20)),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                });
          },
        );
      },
    );
  }
}
