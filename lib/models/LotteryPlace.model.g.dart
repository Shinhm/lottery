// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LotteryPlace.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LotteryWinningPlaceModel _$LotteryWinningPlaceModelFromJson(
    Map<String, dynamic> json) {
  return LotteryWinningPlaceModel(
    json['shopName'] as String,
    json['address'] as String,
    (json['lat'] as num)?.toDouble(),
    (json['lng'] as num)?.toDouble(),
    json['gameType'] as String,
  );
}

Map<String, dynamic> _$LotteryWinningPlaceModelToJson(
        LotteryWinningPlaceModel instance) =>
    <String, dynamic>{
      'shopName': instance.shopName,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'gameType': instance.gameType,
    };

LotteryPlaceModel _$LotteryPlaceModelFromJson(Map<String, dynamic> json) {
  return LotteryPlaceModel(
    json['drawNo'] as int,
    json['drawDate'] as String,
    json['drawDateYn'] as String,
    (json['winningPlaces'] as List)
        ?.map((e) => e == null
            ? null
            : LotteryWinningPlaceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LotteryPlaceModelToJson(LotteryPlaceModel instance) =>
    <String, dynamic>{
      'drawNo': instance.drawNo,
      'drawDate': instance.drawDate,
      'drawDateYn': instance.drawDateYn,
      'winningPlaces': instance.winningPlaces,
    };
