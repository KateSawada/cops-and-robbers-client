import 'package:flutter/material.dart';

class PersonMarkerButton extends StatelessWidget {
  // double radius;
  final VoidCallback onPressed;
  final double radius;
  final Color backGroundColor;

  const PersonMarkerButton({
    super.key,
    required this.onPressed,
    required this.backGroundColor,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backGroundColor,
      onPressed: onPressed,
      child: const Icon(Icons.person),
    );
  }
}
