import 'package:flutter/material.dart';
import 'package:games_bk/models/player.dart';
import 'package:rainbow_color/rainbow_color.dart';

import '../../themes/color.dart';


class MCFinish extends StatefulWidget {
  const MCFinish({Key? key, required this.winner}) : super(key: key);

  final MCPlayer? winner;

  @override
  State<MCFinish> createState() => _MCFinishState();
}

class _MCFinishState extends State<MCFinish> with SingleTickerProviderStateMixin{

  late MCPlayer? winner;
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;
  late Animation sizeFontAnimation;
  late Animation buttonSizeFontAnimation;
  late Animation<Color> rainbowColorAnimation;

  @override
  void initState() {
    super.initState();
    winner = widget.winner;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (winner != null)?
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              height: 130,
              child: Container(
                padding: const EdgeInsets.only(top:25.0),
                child: Text(
                  winner!.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w800,
                    color: rainbowColorAnimation.value,
                  ),
                ),
              ),
            ):
            Container(),
            SizedBox(
              height: sizeAnimation.value,
              width: sizeAnimation.value,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
                    child: Text(
                      'Congrats \n You Win !!',
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

