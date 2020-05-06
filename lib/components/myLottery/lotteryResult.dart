import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/helper/numberFormatHelper.dart';
import 'package:lottery/models/Lottery.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/models/MyLotteryNumbers.model.dart';

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
        var hasError = lotterySnapshot.hasError;
        var error = lotterySnapshot.error;

        if (!hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: myLotteryList,
          builder: (context, snapshot) {
            var hasData = snapshot.hasData;
            List<MyLotteryListModel> data = snapshot.data;
            var hasError = snapshot.hasError;
            var error = snapshot.error;

            if (!hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setSp(50)),
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: ScreenUtil().setHeight(1100),
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
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(62, 52, 181, 1)),
                      child: Container(
                          padding: EdgeInsets.all(9),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    LotteryItem(
                                      active: lotteryNo.num1 == myLottery.num1,
                                      lotteryNumber: myLottery.num1,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                    LotteryItem(
                                      active: lotteryNo.num2 == myLottery.num2,
                                      lotteryNumber: myLottery.num2,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                    LotteryItem(
                                      active: lotteryNo.num3 == myLottery.num3,
                                      lotteryNumber: myLottery.num3,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                    LotteryItem(
                                      active: lotteryNo.num4 == myLottery.num4,
                                      lotteryNumber: myLottery.num4,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                    LotteryItem(
                                      active: lotteryNo.num5 == myLottery.num5,
                                      lotteryNumber: myLottery.num5,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                    LotteryItem(
                                      active: lotteryNo.num6 == myLottery.num6,
                                      lotteryNumber: myLottery.num6,
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                  ],
                                )),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().setWidth(160),
                                        height: ScreenUtil().setHeight(75),
                                        child: Center(
                                          child: Text(
                                            '보너스번호  :',
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(25),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ],
                                  ),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setSp(18)),
                                      child: Container(
                                          height: ScreenUtil().setHeight(700),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Color.fromRGBO(100, 92, 195, 1),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenUtil().setSp(40)),
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          ScreenUtil().setSp(180)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: <Widget>[
                                                      Text(
                                                        '$rank등',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(35),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                                  textBaseline: TextBaseline.alphabetic,
                                                  children: <Widget>[
                                                    Text(
                                                      '총상금은 ',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Icon(
                                                      FontAwesome.won,
                                                      color: Colors.white,
                                                      size:
                                                          ScreenUtil().setSp(24),
                                                    ),
                                                    Text(
                                                      ' ${NumberFormatHelper.numberFormat(rankInfo.sellingPriceByRank)}',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(26),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' 이고,',
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          ScreenUtil().setSp(10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: <Widget>[
                                                      Text(
                                                        '당첨인원은 ',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Icon(
                                                        FontAwesome.users,
                                                        color: Colors.white,
                                                        size: ScreenUtil()
                                                            .setSp(20),
                                                      ),
                                                      Text(
                                                        ' ${NumberFormatHelper.numberFormat(rankInfo.winningCnt)}',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(28),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        '입니다. ',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          ScreenUtil().setSp(10)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                                    textBaseline: TextBaseline.alphabetic,
                                                    children: <Widget>[
                                                      Text(
                                                        '받을 금액은 ',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Icon(
                                                        FontAwesome.won,
                                                        color: Colors.white,
                                                        size: ScreenUtil()
                                                            .setSp(20),
                                                      ),
                                                      Text(
                                                        ' ${NumberFormatHelper.numberFormat(rankInfo.winningPriceByRank)}',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(28),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        '입니다. ',
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(20),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                          )),
                                    ),
                                    rank < 4
                                        ? Positioned(
                                            left: ScreenUtil().setWidth(310) / 2,
                                            width: ScreenUtil().setWidth(90),
                                            child: Container(
                                              child: Image.asset(
                                                  'assets/images/prize.png'),
                                            ),
                                          )
                                        : null,
                                  ].where((Object o) => o != null).toList(),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
            );
          },
        );
      },
    );
  }
}
