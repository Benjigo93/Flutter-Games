import 'dart:math';

import 'package:flutter/material.dart';

Random rd = Random();

List<Color> colors = [
  const Color.fromRGBO(26, 188, 156, 1),
  const Color.fromRGBO(46, 204, 113, 1),
  const Color.fromRGBO(52, 152, 219, 1),
  const Color.fromRGBO(155, 89, 182, 1),
  const Color.fromRGBO(52, 73, 94, 1),
  const Color.fromRGBO(241, 196, 15, 1),
  const Color.fromRGBO(230, 126, 34, 1),
  const Color.fromRGBO(231, 76, 60, 1),
  const Color.fromRGBO(149, 165, 166, 1),
  const Color.fromRGBO(236, 240, 241, 1)
];

class ThemeColor {
  final double opacity;

  const ThemeColor({
    this.opacity = 1,
  });

  Color get darkBrown => Color.fromRGBO(66, 44, 39, opacity);
  Color get lightBrown => Color.fromRGBO(141, 110, 99, opacity);
}

Color randomColor () {
  return colors[rd.nextInt(colors.length-1)];
}