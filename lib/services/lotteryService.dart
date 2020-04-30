import 'dart:convert';
import 'package:lottery/models/Lottery.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/MyLotteryList.dart';

const host = 'https://www.geniecontents.com';

Future<Lottery> fetchLottery(drwNo) async {
  final response = await http.get(
      "https://www.geniecontents.com/api/v1/lotto?drawNo=20");
  print("${jsonDecode(response.body)['body']}");
  if (response.statusCode == 200) {
    return Lottery.fromJson(json.decode(response.body)['body']);
  } else {
    throw Exception('로또정보가 없는데염');
  }
}

List<MyLotteryList> parseMyLotteryList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<MyLotteryList>((json) => MyLotteryList.fromJson(json))
      .toList();
}

Future<List<MyLotteryList>> fetchMyLottery(int drwNo) async {
  var responseBody;
  if (drwNo == 908) {
    responseBody = [
      {
        "id": 100,
        "totalAmount": 100,
        "drwNo": 908,
        "lotteryNumbers": {
          "num1": 3,
          "num2": 16,
          "num3": 21,
          "num4": 22,
          "num5": 23,
          "num6": 44,
          "bnusNum": 27
        }
      },
      {
        "id": 100,
        "totalAmount": 100,
        "drwNo": 908,
        "lotteryNumbers": {
          "num1": 3,
          "num2": 10,
          "num3": 13,
          "num4": 27,
          "num5": 23,
          "num6": 44,
          "bnusNum": 40
        }
      }
    ];
  } else {
    responseBody = [
      {
        "id": 100,
        "totalAmount": 100,
        "drwNo": 908,
        "lotteryNumbers": {
          "num1": 3,
          "num2": 16,
          "num3": 21,
          "num4": 22,
          "num5": 23,
          "num6": 44,
          "bnusNum": 27
        }
      }
    ];
  }
  return parseMyLotteryList(jsonEncode(responseBody));
}

Future<List<MyLotteryList>> fetchMyLotteryList() async {
  var jsonData = [
    {
      "id": 100,
      "totalAmount": 100,
      "drwNo": 908,
      "lotteryNumbers": {
        "num1": 3,
        "num2": 16,
        "num3": 21,
        "num4": 22,
        "num5": 23,
        "num6": 44,
        "bnusNum": 30
      }
    },
    {
      "id": 100,
      "totalAmount": 100,
      "drwNo": 908,
      "lotteryNumbers": {
        "num1": 3,
        "num2": 16,
        "num3": 21,
        "num4": 22,
        "num5": 23,
        "num6": 44,
        "bnusNum": 30
      }
    },
    {
      "id": 100,
      "totalAmount": 100,
      "drwNo": 100,
      "lotteryNumbers": {
        "num1": 3,
        "num2": 16,
        "num3": 21,
        "num4": 22,
        "num5": 23,
        "num6": 44,
        "bnusNum": 30
      }
    }
  ];

  return parseMyLotteryList(jsonEncode(jsonData));
}
