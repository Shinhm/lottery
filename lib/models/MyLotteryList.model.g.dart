// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyLotteryList.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyLotteryList _$MyLotteryListFromJson(Map<String, dynamic> json) {
  return MyLotteryList(
    json['lotteryNumbers'] == null
        ? null
        : LotteryNumbers.fromJson(
            json['lotteryNumbers'] as Map<String, dynamic>),
    json['id'] as int,
    json['totalAmount'] as int,
    json['drwNo'] as int,
  );
}

Map<String, dynamic> _$MyLotteryListToJson(MyLotteryList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'drwNo': instance.drwNo,
      'lotteryNumbers': instance.lotteryNumbers,
    };
