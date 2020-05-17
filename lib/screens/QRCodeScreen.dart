import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:lottery/services/lotteryService.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class QRCodeScreen extends StatefulWidget {
  final VoidCallback callbackJumpToHomeScreen;

  const QRCodeScreen({Key key, @required this.callbackJumpToHomeScreen}) : super(key: key);

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  void main() async {
    try {
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
      print("drwTitle = $drwTitle");
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
    } catch(e) {

    } finally {
      widget.callbackJumpToHomeScreen(); //QR 카메라 사용후 홈스크린으로 이동
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
