import 'package:flutter/material.dart';

class ThemeColor {
  final double opacity;

  const ThemeColor({
    required this.opacity,
  });

  Color get darkBrown => Color.fromRGBO(66, 44, 39, opacity);
  Color get lightBrown => Color.fromRGBO(141, 110, 99, opacity);
}