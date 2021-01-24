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
  final int totSellamnt; //  누적 상금
  final int drwNo; //  로또회차
  final String drwNoDate; //  로또당첨일시
  final String drawDateYn; //  로또당첨일시 맞는지 아닌지
  final int drwtNo1; //  로또번호1
  final int drwtNo2; //  로또번호2
  final int drwtNo3; //  로또번호3
  final int drwtNo4; //  로또번호4
  final int drwtNo5; //  로또번호5
  final int drwtNo6; //  로또번호6
  final int bnusNo; //  보너스번호
  final String success;
  final int firstWinamnt;
  final int firstPrzwnerCo;
  final int firstAccumamnt;

  Lottery(
      this.lottoResult,
      this.totSellamnt,
      this.drawDateYn,
      this.drwNo,
      this.drwNoDate,
      this.drwtNo1,
      this.drwtNo2,
      this.drwtNo3,
      this.drwtNo4,
      this.drwtNo5,
      this.drwtNo6,
      this.bnusNo,
      this.success,
      this.firstWinamnt,
      this.firstPrzwnerCo,
      this.firstAccumamnt);

  factory Lottery.fromJson(Map<String, dynamic> json) =>
      _$LotteryFromJson(json);
}
