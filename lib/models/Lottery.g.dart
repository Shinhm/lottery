// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lottery.dart';

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
    json['totalSellingPrice'] as int,
    json['drawNo'] as int,
    json['drawDate'] as String,
    json['num1'] as int,
    json['num2'] as int,
    json['num3'] as int,
    json['num4'] as int,
    json['num5'] as int,
    json['num6'] as int,
    json['bonusNum'] as int,
    json['drawDateYn'] as String,
  );
}

Map<String, dynamic> _$LotteryToJson(Lottery instance) => <String, dynamic>{
      'lottoResult': instance.lottoResult,
      'totalSellingPrice': instance.totalSellingPrice,
      'drawNo': instance.drawNo,
      'drawDate': instance.drawDate,
      'drawDateYn': instance.drawDateYn,
      'num1': instance.num1,
      'num2': instance.num2,
      'num3': instance.num3,
      'num4': instance.num4,
      'num5': instance.num5,
      'num6': instance.num6,
      'bonusNum': instance.bonusNum,
    };
