// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyLotteryList.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyLotteryListModel _$MyLotteryListModelFromJson(Map<String, dynamic> json) {
  return MyLotteryListModel(
    id: json['id'] as int,
    drwNo: json['drwNo'] as int,
    num1: json['num1'] as int,
    num2: json['num2'] as int,
    num3: json['num3'] as int,
    num4: json['num4'] as int,
    num5: json['num5'] as int,
    num6: json['num6'] as int,
  );
}

Map<String, dynamic> _$MyLotteryListModelToJson(MyLotteryListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'drwNo': instance.drwNo,
      'num1': instance.num1,
      'num2': instance.num2,
      'num3': instance.num3,
      'num4': instance.num4,
      'num5': instance.num5,
      'num6': instance.num6,
    };
