import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottery/models/LotteryPlace.model.dart';
import 'package:lottery/services/lotteryService.dart';

class MapScreen extends StatefulWidget {
  final int drwNo;

  MapScreen({Key key, @required this.drwNo}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Future<LotteryPlaceModel> lotteryPlace;
  String dropdownValue;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  CameraPosition firstCameraSetting(lat, lng) => CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.4746,
      );

  @override
  void initState() {
    super.initState();
    lotteryPlace = fetchLotteryWinningPlace(widget.drwNo);
    dropdownValue = "${widget.drwNo} 회차";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            ScreenUtil.init(context, width: 550, height: 1334);
            return FutureBuilder<LotteryPlaceModel>(
              future: lotteryPlace,
              builder:
                  (BuildContext context, AsyncSnapshot lotteryPlaceSnapShot) {
                if (!lotteryPlaceSnapShot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                LotteryPlaceModel data = lotteryPlaceSnapShot.data;
                List<LotteryWinningPlaceModel> winningPlaces =
                    data.winningPlaces;
                print(winningPlaces[0].shopName);
                List<String> dropdownArray = [];
                for (var i = widget.drwNo; i > 1; i--) {
                  dropdownArray.add("$i 회차");
                }
                return Column(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(1000),
                      child: Stack(
                        children: <Widget>[
                          GoogleMap(
                            markers: Set<Marker>.of(markers.values),
                            mapType: MapType.normal,
                            initialCameraPosition: firstCameraSetting(
                                data.winningPlaces[0].lat,
                                data.winningPlaces[0].lng),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);

                              for (final winningPlace in winningPlaces) {
                                _addMaker(winningPlace.lat, winningPlace.lng);
                              }
                            },
                          ),
                          Positioned(
                            top: 25,
                            left: 10,
                            child: Container(
                              width: ScreenUtil().setWidth(130),
                              height: ScreenUtil().setHeight(90),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Center(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  elevation: 16,
                                  icon: Icon(FontAwesome.sort_down),
                                  iconSize: 20,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String value) async {
                                    setState(() {
                                      _markerIdCounter = 1;
                                      lotteryPlace = fetchLotteryWinningPlace(
                                          value.split(" ")[0]);
                                      lotteryPlace.then((place) {
                                        var _winningPlaces =
                                            place.winningPlaces;
                                        _goToPlace(_winningPlaces[0].lat,
                                            _winningPlaces[0].lng);
                                        for (final winningPlace
                                            in _winningPlaces) {
                                          _addMaker(winningPlace.lat,
                                              winningPlace.lng);
                                        }
                                      });
                                      dropdownValue = value;
                                    });
                                  },
                                  items: dropdownArray
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Container(
                              width: ScreenUtil().setWidth(80),
                              height: ScreenUtil().setHeight(70),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: ScreenUtil().setSp(30),
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                            height: ScreenUtil().setHeight(190),
                            autoPlay: false,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            initialPage: 1,
                            onPageChanged: (index, reason) {
                              LotteryWinningPlaceModel lwpm =
                                  winningPlaces[index];
                              _goToPlace(lwpm.lat, lwpm.lng);
                            }),
                        itemCount: winningPlaces.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          LotteryWinningPlaceModel lwpm =
                              winningPlaces[itemIndex];
                          Map<String, String> gameTypeMap = <String, String>{
                            "AUTO": "자동",
                            "SEMI_AUTO": "반자동",
                            "MANUAL": "수동",
                            "UNKNOWN": "알수없음"
                          };
                          return Container(
                            width: ScreenUtil().setWidth(550),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "${lwpm.shopName} ( ${lwpm.lat}, ${lwpm.lng} ) - ${gameTypeMap[lwpm.gameType]}"),
                                  Text(lwpm.address),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _addMaker(lat, lng) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        lat,
        lng,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {},
      onDragEnd: (LatLng position) {},
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void historyBack() {}

  Future<void> _goToPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition =
        CameraPosition(target: LatLng(lat, lng), zoom: 14.4746);
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
