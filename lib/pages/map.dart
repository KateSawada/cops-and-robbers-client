// 時刻を選択して，その時の位置情報が表示される．
// デフォルトでは最新のものを表示
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/marker.dart';

class MapPage extends StatefulWidget {
  @override
  _MapAppState createState() => new _MapAppState();
}

class _MapAppState extends State<MapPage> {
  LatLng nagoyaLatLng = const LatLng(35.1814, 136.9063);
  late Marker marker;

  @override
  void initState() {
    super.initState();
    marker = Marker(
        width: 32,
        height: 32,
        point: nagoyaLatLng,
        builder: (ctx) => PersonMarkerButton(
              radius: 16,
              onPressed: randomWarp,
              backGroundColor: Colors.red,
            ));
  }

  double _randomDoubleWithRange(double min, double max) {
    double value = math.Random().nextDouble() * (max - min);
    return value + min;
  }

  void randomWarp() {
    // マーカーをnagoyaLatLngを中心にランダムに移動させる
    LatLng newLatLng = LatLng(
        nagoyaLatLng.latitude + _randomDoubleWithRange(-0.01, 0.01),
        nagoyaLatLng.longitude + _randomDoubleWithRange(-0.01, 0.01));

    setState(() {
      marker = Marker(
          width: 32,
          height: 32,
          point: newLatLng,
          builder: (ctx) => PersonMarkerButton(
                radius: 16,
                onPressed: randomWarp,
                backGroundColor: Colors.red,
              ));
    });
  }

  final String _title = 'map_app';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'map_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        // flutter_map設定
        body: FlutterMap(
          // マップ表示設定
          options: MapOptions(
            center: nagoyaLatLng,
            zoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [marker],
            ),
          ],
        ),
      ),
    );
  }
}
