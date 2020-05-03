import 'package:json_annotation/json_annotation.dart';

part 'LotteryPlace.model.g.dart';

@JsonSerializable()
class LotteryWinningPlaceModel {
  final String shopName;
  final String address;
  final double lat;
  final double lng;
  final String gameType;

  LotteryWinningPlaceModel(
      this.shopName, this.address, this.lat, this.lng, this.gameType);

  factory LotteryWinningPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryWinningPlaceModelFromJson(json);
}

@JsonSerializable()
class LotteryPlaceModel {
  final int drawNo;
  final String drawDate;
  final String drawDateYn;
  final List<LotteryWinningPlaceModel> winningPlaces;

  LotteryPlaceModel(
      this.drawNo, this.drawDate, this.drawDateYn, this.winningPlaces);

  factory LotteryPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$LotteryPlaceModelFromJson(json);
}
