import 'dart:convert';
import 'package:lottery/models/Lottery.model.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/LotteryPlace.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const host = 'https://www.geniecontents.com';

Future<Lottery> fetchLottery(drwNo) async {
  final response = await http.get("$host/api/v1/lotto?drawNo=$drwNo");
  var responseBody = json.decode(response.body);
  if (responseBody['statusCode'] == '200') {
    return Lottery.fromJson(responseBody['body']);
  } else {
    throw Exception('로또 정보가 없는데염');
  }
}

Future<LotteryPlaceModel> fetchLotteryWinningPlace(drwNo) async {
  final response = await http.get(
      "$host/api/v1/lotto/winning/places?drawNo=$drwNo");
  var responseBody = json.decode(response.body);
  if (responseBody['statusCode'] == '200') {
    return LotteryPlaceModel.fromJson(responseBody['body']);
  } else {
    throw Exception('로또 매장 정보가 없는데염');
  }
}

List<MyLotteryListModel> parseMyLotteryList(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<MyLotteryListModel>((json) => MyLotteryListModel.fromJson(json))
      .toList();
}

Future<List<MyLotteryListModel>> fetchMyLottery(int drwNo) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.rawQuery('select * from my_lottery_list where drwNo = $drwNo order by drwNo desc');
  return parseMyLotteryList(jsonEncode(maps));
}

Future<List<MyLotteryListModel>> fetchMyLotteryList() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.rawQuery('select * from my_lottery_list order by drwNo desc');
  return parseMyLotteryList(jsonEncode(maps));
}

Future<void> addLotteryNumbers(MyLotteryListModel myLotteryListModel) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  // 데이터베이스 reference를 얻습니다.
  final Database db = await database;

  // Dog를 올바른 테이블에 추가하세요. 또한
  // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
  // 만약 동일한 dog가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
  await db.insert(
    'my_lottery_list',
    myLotteryListModel.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}