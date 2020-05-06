import 'MyLotteryNumbers.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MyLotteryList.model.g.dart';

@JsonSerializable()
class MyLotteryListModel {
  int drwNo;
  final int num1;
  final int num2;
  final int num3;
  final int num4;
  final int num5;
  final int num6;

  MyLotteryListModel(this.drwNo, this.num1, this.num2, this.num3, this.num4,
      this.num5, this.num6);

  factory MyLotteryListModel.fromJson(Map<String, dynamic> json) =>
      _$MyLotteryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyLotteryListModelToJson(this);

}
