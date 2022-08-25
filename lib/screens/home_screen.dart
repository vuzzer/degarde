import 'package:degarde/helpers/network_helper.dart';
import 'package:degarde/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static LatLng? corner1 = LatLng(5.345317, -4.024429);
  static LatLng? corner2 = LatLng(5.245317, -4.014429);

  List<LatLng> polyPoints = [];

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      
        startLng: -4.0033, startLat:  5.2937, endLng: -3.9879, endLat:   5.3545);

    try {
      // getData() returns a json Decoded data
      final data = await network.getData() as Map;

      // We can reach to our desired JSON data manually as following
      List ls = data['features'][0]['geometry']['coordinates'] as List;

      for (int i = 0; i < ls.length; i++) {
        polyPoints.add(LatLng(ls[i][1], ls[i][0]));
      }

      if (polyPoints.length == ls.length) {
        //print(ls);
        //print(polyPoints);
      }
    } catch (e) {
      print(e);
      //print(polyPoints);
    }
  }

  @override
  Widget build(BuildContext context) {
    getJsonData();
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(5.295317, -4.019429),
            slideOnBoundaries: true,
            bounds: LatLngBounds(corner1, corner2),
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.degarde',
                retinaMode: true && media.devicePixelRatio > 1.0,
                subdomains: ['a', 'b', 'c']),
            //Polyline layer
            PolylineLayerOptions(polylineCulling: false, polylines: [
              Polyline(
                points: polyPoints,
                color: CupertinoColors.activeBlue,
                strokeWidth: 5.0,
              )
            ]),
            //Marker layer
            MarkerLayerOptions(markers: [
              Marker(
                  point: LatLng(5.2937, -4.0033),
                  width: 45,
                  height: 45,
                  builder: (context) => IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.map_pin,
                        size: 45,
                        color: CupertinoColors.activeOrange,
                      ))),
              Marker(
                  point: LatLng(5.3545, -3.9879),
                  width: 45,
                  height: 45,
                  builder: (context) => IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.map_pin,
                          size: 45, color: CupertinoColors.systemRed)))
            ])
          ],
        ),
        Positioned(
            bottom: 0,
            child: Container(
                decoration: const BoxDecoration(color: CupertinoColors.white),
                height: 150,
                width: media.size.width,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(10, (index) => const CardWidget())
                        .toList())))
      ]),
    );
  }
}
