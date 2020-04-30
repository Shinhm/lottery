import 'MyLotteryNumbers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MyLotteryList.g.dart';

@JsonSerializable()
class MyLotteryList {
  int id;
  int totalAmount;
  int drwNo;
  LotteryNumbers lotteryNumbers;

  MyLotteryList(this.lotteryNumbers, this.id, this.totalAmount, this.drwNo);

  factory MyLotteryList.fromJson(Map<String, dynamic> json) =>
      _$MyLotteryListFromJson(json);
}
