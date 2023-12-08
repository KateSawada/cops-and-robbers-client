import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:math';
import 'package:latlong2/latlong.dart';

Marker getMarkerButton(LatLng point, double radius, Color backGroundColor,
    String text, VoidCallback onPressed) {
  return Marker(
      point: point,
      width: max(12.5 * text.length, radius),
      height: radius + 42,
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
                alignment: Alignment.center,
                width: 200,
                // height: 40,
                // color: backGroundColor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: backGroundColor,
                ),
                padding: const EdgeInsets.all(4),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ));
}
