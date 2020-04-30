// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyLotteryNumbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryNumbers _$LotteryNumbersFromJson(Map<String, dynamic> json) {
  return LotteryNumbers(
    json['num1'] as int,
    json['num2'] as int,
    json['num3'] as int,
    json['num4'] as int,
    json['num5'] as int,
    json['num6'] as int,
    json['bnusNum'] as int,
  );
}

Map<String, dynamic> _$LotteryNumbersToJson(LotteryNumbers instance) =>
    <String, dynamic>{
      'num1': instance.num1,
      'num2': instance.num2,
      'num3': instance.num3,
      'num4': instance.num4,
      'num5': instance.num5,
      'num6': instance.num6,
      'bnusNum': instance.bnusNum,
    };
