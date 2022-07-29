import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:games_bk/models/card.dart';
import 'package:games_bk/themes/color.dart';

typedef NotifyFlip = void Function(int id);

class MCFlipCard extends StatefulWidget {
  const MCFlipCard({Key? key, required this.level, required this.card, required this.id, required this.onFlip}) : super(key: key);

  final int level;
  final MCCard card;
  final int id;
  final NotifyFlip onFlip;

  @override
  State<MCFlipCard> createState() => MCFlipCardState();
}

class MCFlipCardState extends State<MCFlipCard> {

  late int level;
  late MCCard card;
  late int id;
  late NotifyFlip onFlip;
  late bool initFlipAnimation;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    card = widget.card;
    id = widget.id;
    initFlipAnimation = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var start = id * (widget.level * 80);
      var end = start + 1000 + (widget.level * 500);
      Timer(Duration(milliseconds: start), flipCard);
      Timer(Duration(milliseconds: end), () => {
        flipCard(),
        setState(() {
          initFlipAnimation = false;
        })
      });
    });
  }

  void flipCard(){
    cardKey.currentState?.toggleCard();
    card.setFlipped(!card.flipped);
  }

  void onTapCard() {
    if (initFlipAnimation == false) {
      flipCard();
      widget.onFlip(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 0.0),
      child: FlipCard(
        flipOnTouch: false,
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        speed: 275,
        front: GestureDetector(
          onTap: () => onTapCard(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.width * 0.20,
            child: Container(
              color: const ThemeColor().lightBrown,
            ),
          ),
        ),
        back: SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          height: MediaQuery.of(context).size.width * 0.20,
          child: Container(
            color: card.color,
            child: CircleAvatar(
              backgroundColor: card.color,
              child: Padding(
                padding: const EdgeInsets.all(25), // Border radius
                child: ClipOval(child: Image.asset(
                  card.image,
                  fit: BoxFit.cover,
                )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
