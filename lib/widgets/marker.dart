import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker getMarkerButton(LatLng point, double radius, Color backGroundColor,
    VoidCallback onPressed) {
  return Marker(
      point: point,
      width: radius,
      height: radius,
      builder: (ctx) => FloatingActionButton(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: onPressed,
            backgroundColor: backGroundColor,
          ));
}
