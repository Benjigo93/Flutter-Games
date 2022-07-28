import 'package:flutter/material.dart';


class TextWithStroke extends StatelessWidget{
  const TextWithStroke({
    Key? key,
    required this.title,
    required this.strokeColor,
    required this.color,
    required this.size,
    required this.strokeWidth
  }) : super(key: key);

  final String title;
  final Color strokeColor;
  final Color color;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(
          title,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Solid text as fill.
        Text(
          title,
          style: TextStyle(
            fontSize: size,
            color: color,
          ),
        ),
      ],
    );
  }
}