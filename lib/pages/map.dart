// 時刻を選択して，その時の位置情報が表示される．
// デフォルトでは最新のものを表示
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapAppState createState() => new _MapAppState();
}

class _MapAppState extends State<MapPage> {
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
            center: LatLng(35.681, 139.767),
            zoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: const LatLng(51.5, -0.09),
                  builder: (ctx) => const FlutterLogo(
                    textColor: Colors.blue,
                    key: ObjectKey(Colors.blue),
                  ),
                ),
                Marker(
                  width: 80,
                  height: 80,
                  point: const LatLng(53.3498, -6.2603),
                  builder: (ctx) => const FlutterLogo(
                    textColor: Colors.green,
                    key: ObjectKey(Colors.green),
                  ),
                ),
                Marker(
                  width: 80,
                  height: 80,
                  point: const LatLng(48.8566, 2.3522),
                  builder: (ctx) => const FlutterLogo(
                    textColor: Colors.purple,
                    key: ObjectKey(Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
