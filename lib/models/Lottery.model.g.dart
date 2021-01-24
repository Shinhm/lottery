// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lottery.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryResultModel _$LotteryResultModelFromJson(Map<String, dynamic> json) {
  return LotteryResultModel(
    json['rank'] as String,
    json['sellingPriceByRank'] as int,
    json['winningPriceByRank'] as int,
    json['winningCnt'] as int,
  );
}

Map<String, dynamic> _$LotteryResultModelToJson(LotteryResultModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'sellingPriceByRank': instance.sellingPriceByRank,
      'winningPriceByRank': instance.winningPriceByRank,
      'winningCnt': instance.winningCnt,
    };

Lottery _$LotteryFromJson(Map<String, dynamic> json) {
  return Lottery(
    (json['lottoResult'] as List)
        ?.map((e) => e == null
            ? null
            : LotteryResultModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['totSellamnt'] as int,
    json['drawDateYn'] as String,
    json['drwNo'] as int,
    json['drwNoDate'] as String,
    json['drwtNo1'] as int,
    json['drwtNo2'] as int,
    json['drwtNo3'] as int,
    json['drwtNo4'] as int,
    json['drwtNo5'] as int,
    json['drwtNo6'] as int,
    json['bnusNo'] as int,
    json['success'] as String,
    json['firstWinamnt'] as int,
    json['firstPrzwnerCo'] as int,
    json['firstAccumamnt'] as int,
  );
}

Map<String, dynamic> _$LotteryToJson(Lottery instance) => <String, dynamic>{
      'lottoResult': instance.lottoResult,
      'totSellamnt': instance.totSellamnt,
      'drwNo': instance.drwNo,
      'drwNoDate': instance.drwNoDate,
      'drawDateYn': instance.drawDateYn,
      'drwtNo1': instance.drwtNo1,
      'drwtNo2': instance.drwtNo2,
      'drwtNo3': instance.drwtNo3,
      'drwtNo4': instance.drwtNo4,
      'drwtNo5': instance.drwtNo5,
      'drwtNo6': instance.drwtNo6,
      'bnusNo': instance.bnusNo,
      'success': instance.success,
      'firstWinamnt': instance.firstWinamnt,
      'firstPrzwnerCo': instance.firstPrzwnerCo,
      'firstAccumamnt': instance.firstAccumamnt,
    };
