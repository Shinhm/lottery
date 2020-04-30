import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottery/components/_common/lotteryItem.dart';
import 'package:lottery/helper/numberFormatHelper.dart';
import 'package:lottery/models/Lottery.dart';
import 'package:lottery/models/MyLotteryList.dart';

class LotteryResult extends StatelessWidget {
  final Future<Lottery> lottery;
  final Future<List<MyLotteryList>> myLotteryList;

  const LotteryResult(
      {Key key, @required this.lottery, @required this.myLotteryList})
      : super(key: key);

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
            List<MyLotteryList> data = snapshot.data;
            var hasError = snapshot.hasError;
            var error = snapshot.error;

            if (!hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return CarouselSlider.builder(
                options: CarouselOptions(
                  height: ScreenUtil().setHeight(850),
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  var myLottery = data[itemIndex].lotteryNumbers;
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(62, 52, 181, 1)),
                    child: Container(
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text(
                                    'Selected Number',
                                    style: TextStyle(
                                        color: Color.fromRGBO(223, 222, 243, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(30)),
                                  ),
                                ),
                              ),
                              Container(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  LotteryItem(
                                    active: lotteryNo.num1 == myLottery.num1,
                                    lotteryNumber: myLottery.num1,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
                                    backgroundColor:
                                        Color.fromRGBO(100, 92, 195, 1),
                                  ),
                                  LotteryItem(
                                    active: lotteryNo.num2 == myLottery.num2,
                                    lotteryNumber: myLottery.num2,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
                                    backgroundColor:
                                        Color.fromRGBO(100, 92, 195, 1),
                                  ),
                                  LotteryItem(
                                    active: lotteryNo.num3 == myLottery.num3,
                                    lotteryNumber: myLottery.num3,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
                                    backgroundColor:
                                        Color.fromRGBO(100, 92, 195, 1),
                                  ),
                                  LotteryItem(
                                    active: lotteryNo.num4 == myLottery.num4,
                                    lotteryNumber: myLottery.num4,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
                                    backgroundColor:
                                        Color.fromRGBO(100, 92, 195, 1),
                                  ),
                                  LotteryItem(
                                    active: lotteryNo.num5 == myLottery.num5,
                                    lotteryNumber: myLottery.num5,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
                                    backgroundColor:
                                        Color.fromRGBO(100, 92, 195, 1),
                                  ),
                                  LotteryItem(
                                    active: lotteryNo.num6 == myLottery.num6,
                                    lotteryNumber: myLottery.num6,
                                    fontColor: Color.fromRGBO(223, 222, 243, 1),
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
                                      height: ScreenUtil().setHeight(85),
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
                                    LotteryItem(
                                      active:
                                          lotteryNo.bonusNum == myLottery.bnusNum,
                                      lotteryNumber: myLottery.bnusNum,
                                      fontColor:
                                          Color.fromRGBO(223, 222, 243, 1),
                                      backgroundColor:
                                          Color.fromRGBO(100, 92, 195, 1),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '1등 총상금',
                                        style: TextStyle(
                                          color: Color.fromRGBO(223, 222, 243, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setSp(10)),
                                          child: Icon(
                                            FontAwesome.won,
                                            color: Colors.white,
                                            size: ScreenUtil().setSp(20),
                                          ),
                                        ),
                                        Text(
                                          NumberFormatHelper.numberFormat(
                                            lotteryNo.firstAccumamnt,
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '1등 당첨금액',
                                        style: TextStyle(
                                          color: Color.fromRGBO(223, 222, 243, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: ScreenUtil().setSp(10)),
                                          child: Icon(
                                            FontAwesome.won,
                                            color: Colors.white,
                                            size: ScreenUtil().setSp(20),
                                          ),
                                        ),
                                        Text(
                                          NumberFormatHelper.numberFormat(
                                            lotteryNo.firstWinamnt,
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ScreenUtil().setSp(30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '1등 당첨자',
                                        style: TextStyle(
                                          color: Color.fromRGBO(223, 222, 243, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        "${lotteryNo.firstPrzwnerCo} 명",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                });
          },
        );
      },
    );
  }
}
