import 'package:json_annotation/json_annotation.dart';

part 'Lottery.model.g.dart';

@JsonSerializable()
class LotteryResultModel {
  final String rank;
  final int sellingPriceByRank;
  final int winningPriceByRank;
  final int winningCnt;

  LotteryResultModel(this.rank, this.sellingPriceByRank,
      this.winningPriceByRank, this.winningCnt);

  factory LotteryResultModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryResultModelFromJson(json);
}

@JsonSerializable()
class Lottery {
  final List<LotteryResultModel> lottoResult; //  json 결과값 (success 또는 fail)
  final int totalSellingPrice; //  누적 상금
  final int drawNo; //  로또회차
  final String drawDate; //  로또당첨일시
  final String drawDateYn; //  로또당첨일시 맞는지 아닌지
  final int num1; //  로또번호1
  final int num2; //  로또번호2
  final int num3; //  로또번호3
  final int num4; //  로또번호4
  final int num5; //  로또번호5
  final int num6; //  로또번호6
  final int bonusNum; //  보너스번호

  Lottery(
      this.lottoResult,
      this.totalSellingPrice,
      this.drawNo,
      this.drawDate,
      this.num1,
      this.num2,
      this.num3,
      this.num4,
      this.num5,
      this.num6,
      this.bonusNum,
      this.drawDateYn);

  factory Lottery.fromJson(Map<String, dynamic> json) =>
      _$LotteryFromJson(json);
}
