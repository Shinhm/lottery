import 'dart:convert';
import 'package:lottery/models/Lottery.model.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/LotteryPlace.model.dart';
import 'package:lottery/models/MyLotteryList.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const host = 'https://www.geniecontents.com';

Future<Lottery> fetchLottery(drwNo) async {
  final response = await http.get(
      "http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=$drwNo");
  var responseBody = json.decode(response.body);
  if (responseBody['returnValue'] == 'success') {
    return Lottery.fromJson(responseBody);
  } else {
    throw Exception('로또 정보가 없는데염');
  }
}

Future<LotteryPlaceModel> fetchLotteryWinningPlace(drwNo) async {
  final response =
      await http.get("$host/api/v1/lotto/winning/places?drawNo=$drwNo");
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
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY AUTOINCREMENT, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.rawQuery(
      'select * from my_lottery_list where drwNo = $drwNo order by drwNo desc');
  return parseMyLotteryList(jsonEncode(maps));
}

Future<List<MyLotteryListModel>> fetchMyLotteryList() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY AUTOINCREMENT, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  final Database db = await database;
  final List<Map<String, dynamic>> maps =
      await db.rawQuery('select * from my_lottery_list order by drwNo desc');
  return parseMyLotteryList(jsonEncode(maps));
}

Future<void> addLotteryNumbers(MyLotteryListModel myLotteryListModel) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY AUTOINCREMENT, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );
  // 데이터베이스 reference를 얻습니다.
  final Database db = await database;

  var selectList = await db.rawQuery(
      'select count(*) count from my_lottery_list where num1=${myLotteryListModel.num1} and num2=${myLotteryListModel.num2} and num3=${myLotteryListModel.num3} and num4=${myLotteryListModel.num4} and num5=${myLotteryListModel.num5} and num6=${myLotteryListModel.num6}');
  int count = selectList[0]['count'];
  if (count == 0) {
    await db.insert(
      'my_lottery_list',
      myLotteryListModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

Future<void> deleteLotteryNumbers(int id) async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'lottery.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE my_lottery_list(id INTEGER PRIMARY KEY AUTOINCREMENT, drwNo INTEGER, num1 INTEGER, num2 INTEGER, num3 INTEGER, num4 INTEGER, num5 INTEGER, num6 INTEGER)",
      );
    },
    version: 1,
  );

  final Database db = await database;

  await db.delete(
    'my_lottery_list',
    where: "id = ?",
    whereArgs: [id],
  );
}
