import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker getMarkerButton(LatLng point, double radius, Color backGroundColor,
    String text, VoidCallback onPressed) {
  return Marker(
      point: point,
      width: radius + 40,
      height: radius + 40,
      builder: (ctx) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: radius,
                width: radius,
                child: FloatingActionButton(
                  onPressed: onPressed,
                  backgroundColor: backGroundColor,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                // color: backGroundColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: backGroundColor,
                ),
                padding: EdgeInsets.all(4),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ));
}
