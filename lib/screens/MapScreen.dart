import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottery/components/_common/skeleton.dart';
import 'package:lottery/models/LotteryPlace.model.dart';
import 'package:lottery/services/lotteryService.dart';
import 'package:lottie/lottie.dart';

class MapScreen extends StatefulWidget {
  final int drwNo;

  MapScreen({Key key, @required this.drwNo}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final CarouselController _carouselController = CarouselController();
  Future<LotteryPlaceModel> lotteryPlace;
  String dropdownValue;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;
  List<String> dropdownArray;

  CameraPosition firstCameraSetting(lat, lng) => CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.4746,
      );

  @override
  void initState() {
    super.initState();
    lotteryPlace = fetchLotteryWinningPlace(widget.drwNo);
    dropdownValue = "${widget.drwNo} 회차";
    dropdownArray = [];
    for (var i = widget.drwNo; i > 1; i--) {
      dropdownArray.add("$i 회차");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          value: dropdownValue,
          elevation: 6,
          iconSize: 20,
          isExpanded: true,
          underline: Container(
            height: 0,
          ),
          onChanged: (String value) async {
            setState(() {
              _markerIdCounter = 1;
              lotteryPlace =
                  fetchLotteryWinningPlace(value.split(" ")[0]).then((place) {
                markers.clear();
                var _winningPlaces = place.winningPlaces;
                for (final winningPlace in _winningPlaces) {
                  _addMaker(winningPlace.lat, winningPlace.lng);
                }
                _carouselController.jumpToPage(0);
                _goToPlace(_winningPlaces[0].lat, _winningPlaces[0].lng);
                return place;
              });
              dropdownValue = value;
            });
          },
          items: dropdownArray.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(child: Text(value)),
            );
          }).toList(),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ScreenUtil.init(context, width: 375, height: 812);
          return FutureBuilder<LotteryPlaceModel>(
            future: lotteryPlace,
            builder:
                (BuildContext context, AsyncSnapshot lotteryPlaceSnapShot) {
              if (!lotteryPlaceSnapShot.hasData) {
                return Stack(
                  children: <Widget>[
                    Skeleton(
                      width: 375,
                      height: 712,
                    ),
                    Positioned(
                      left: ScreenUtil().setWidth(40),
                      bottom: ScreenUtil().setHeight(80),
                      child: Container(
                        padding: EdgeInsets.only(
                            right: ScreenUtil().setWidth(20),
                            left: ScreenUtil().setWidth(20)),
                        width: ScreenUtil().setWidth(295),
                        height: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(31, 26, 29, .3),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                  offset: Offset(2, 2))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(10)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: ScreenUtil().setWidth(5)),
                                    child: Icon(Icons.store,
                                        size: ScreenUtil().setSp(17)),
                                  ),
                                  Skeleton(
                                    width: 100,
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.ideographic,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(5)),
                                  child: Icon(
                                    FontAwesome.map_marker,
                                    size: ScreenUtil().setSp(17),
                                  ),
                                ),
                                Skeleton(
                                  width: 200,
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              LotteryPlaceModel data = lotteryPlaceSnapShot.data;
              List<LotteryWinningPlaceModel> winningPlaces = data.winningPlaces;
              return Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(712),
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          markers: Set<Marker>.of(markers.values),
                          mapType: MapType.normal,
                          zoomControlsEnabled: false,
                          initialCameraPosition: firstCameraSetting(
                              data.winningPlaces[0].lat,
                              data.winningPlaces[0].lng),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);

                            for (final winningPlace in winningPlaces) {
                              _addMaker(winningPlace.lat, winningPlace.lng);
                            }
                          },
                          myLocationButtonEnabled: false,
                        ),
                        Positioned(
                          bottom: ScreenUtil().setHeight(60),
                          child: Container(
                            width: ScreenUtil().setWidth(375),
                            child: CarouselSlider.builder(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                  height: ScreenUtil().setHeight(140),
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  initialPage: 0,
                                  onPageChanged: (index, reason) {
                                    LotteryWinningPlaceModel lwpm =
                                        winningPlaces[index];
                                    _goToPlace(lwpm.lat, lwpm.lng);
                                  }),
                              itemCount: winningPlaces.length,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) {
                                LotteryWinningPlaceModel lwpm =
                                    winningPlaces[itemIndex];
                                Map<String, String> gameTypeMap =
                                    <String, String>{
                                  "AUTO": "자동",
                                  "SEMI_AUTO": "반자동",
                                  "MANUAL": "수동",
                                  "UNKNOWN": "알수없음"
                                };
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(20),
                                      bottom: ScreenUtil().setHeight(20),
                                      left: ScreenUtil().setWidth(5),
                                      right: ScreenUtil().setWidth(5)),
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(20),
                                      left: ScreenUtil().setWidth(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      ScreenUtil().setWidth(5)),
                                              child: Lottie.asset(
                                                  'assets/lottie/store.json',
                                                  width: 25,
                                                  height: 18),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: ScreenUtil()
                                                      .setHeight(1)),
                                              child: Text(
                                                "${lwpm.shopName} - ${gameTypeMap[lwpm.gameType]}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.ideographic,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    ScreenUtil().setWidth(5)),
                                            child: Lottie.asset(
                                              'assets/lottie/marker.json',
                                              width: 25,
                                              height: 20,
                                              repeat: false,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(1)),
                                            width: ScreenUtil().setWidth(220),
                                            child: Text(
                                              lwpm.address,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(
                                          ScreenUtil().setSp(30)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(31, 26, 29, .3),
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
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
