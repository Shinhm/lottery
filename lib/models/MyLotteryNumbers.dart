import 'package:json_annotation/json_annotation.dart';

part 'MyLotteryNumbers.g.dart';

@JsonSerializable()
class LotteryNumbers {
  final int num1;
  final int num2;
  final int num3;
  final int num4;
  final int num5;
  final int num6;
  final int bnusNum;

  LotteryNumbers(this.num1, this.num2, this.num3, this.num4, this.num5,
      this.num6, this.bnusNum);

  factory LotteryNumbers.fromJson(Map<String, dynamic> json) =>
      _$LotteryNumbersFromJson(json);
}
