// 時刻を選択して，その時の位置情報が表示される．
// デフォルトでは最新のものを表示
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

class MapPage extends StatefulWidget {
  @override
  _MapAppState createState() => new _MapAppState();
}

class _MapAppState extends State<MapPage> {
  LatLng nagoyaLatLng = const LatLng(35.1814, 136.9063);
  late Marker marker;

  late Marker myCurrentMarker = getMarkerButton(
      const LatLng(35.1814, 136.9063), 32, Colors.green, "", () {});
  late LatLng myCurrentLatLng;

  @override
  void initState() {
    super.initState();
    marker =
        getMarkerButton(nagoyaLatLng, 32, Colors.red, "NAGOYA", randomWarp);

    Future(() async {
      await setCurrentPositionMarker();
      setState(() {});
    });
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
      marker = getMarkerButton(newLatLng, 32, Colors.red, "NAGOYA", randomWarp);
    });
  }

  Future<void> setCurrentPositionMarker() async {
    double longitude = 0;
    double latitude = 0;
    // 権限を取得
    LocationPermission permission = await Geolocator.requestPermission();
    // 権限がない場合は戻る
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('位置情報取得の権限がありません');
      return;
    }
    // 位置情報を取得
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      // 北緯がプラス、南緯がマイナス
      latitude = position.latitude;
      // 東経がプラス、西経がマイナス
      longitude = position.longitude;
      print('現在地の緯度は、$latitude');
      print('現在地の経度は、$longitude');
    });
    //取得した緯度経度からその地点の地名情報を取得する
    final placeMarks =
        await geoCoding.placemarkFromCoordinates(latitude, longitude);
    final placeMark = placeMarks[0];
    print("現在地の国は、${placeMark.country}");
    print("現在地の県は、${placeMark.administrativeArea}");
    print("現在地の市は、${placeMark.locality}");
    setState(() {
      String location = placeMark.locality ?? "現在地データなし";
      // ref.read(riverpodNowLocation.notifier).state = Now_location;
      print('現在地は、$location');
    });

    setState(() {
      // marker位置更新
      myCurrentLatLng = LatLng(latitude, longitude);
      myCurrentMarker =
          getMarkerButton(myCurrentLatLng, 32, Colors.green, "me", () {
        print("update current position");
      });
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
              markers: [marker, myCurrentMarker],
            ),
          ],
        ),
      ),
    );
  }
}
