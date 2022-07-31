import 'package:flutter/material.dart';
import 'package:games_bk/models/player.dart';
import 'package:rainbow_color/rainbow_color.dart';

import '../../themes/color.dart';


class TPIRFinish extends StatefulWidget {
  const TPIRFinish({Key? key, required this.win}) : super(key: key);

  final bool win;

  @override
  State<TPIRFinish> createState() => _MCFinishState();
}

class _MCFinishState extends State<TPIRFinish> with SingleTickerProviderStateMixin{

  late bool win;
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  late Animation sizeFontAnimation;
  late Animation buttonSizeFontAnimation;
  late Animation<Color> rainbowColorAnimation;

  @override
  void initState() {
    super.initState();
    win = widget.win;
    controller =  AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    colorAnimation = ColorTween(begin: const ThemeColor().darkBrown, end: Colors.green).animate(controller);
    sizeAnimation = Tween<double>(begin: 100.0, end: 300.0).animate(controller);
    sizeFontAnimation = Tween<double>(begin: 20.0, end: 60.0).animate(controller);
    buttonSizeFontAnimation = Tween<double>(begin: 25.0, end: 30.0).animate(controller);

    rainbowColorAnimation = RainbowColorTween([
      const ThemeColor().darkBrown,
      Colors.blue,
      const ThemeColor().lightBrown,
      Colors.green,
      const ThemeColor().darkBrown,
    ]).animate(controller);

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                    child: Text(
                      win ? 'Congrats \n You Win !!' : 'Game Over \n You lost...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sizeFontAnimation.value,
                        fontWeight: FontWeight.w600,
                        color: colorAnimation.value,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
            child: Text(
                'Go Home',
                style: TextStyle(
                  fontSize: buttonSizeFontAnimation.value,
                  fontWeight: FontWeight.w600,
                )
            ),
          ),
        ),
      ),
    );
  }
}

