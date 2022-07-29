import 'dart:async';

import 'package:flutter/material.dart';
import 'package:games_bk/components/mc_card.dart';
import 'package:games_bk/models/player.dart';

import '../../models/card.dart';
import '../../pages/matching_cards.dart';
import '../../themes/color.dart';
import '../../themes/image.dart';

typedef FinishGame = void Function(bool finish, MCPlayer? winner);

class MCMainGame extends StatefulWidget {
  const MCMainGame({Key? key, required this.playersCount, required this.level, required this.onFinish}) : super(key: key);

  final int playersCount;
  final int level;
  final FinishGame onFinish;

  @override
  State<MCMainGame> createState() => _MCMAinGameState();
}

class _MCMAinGameState extends State<MCMainGame> {

  late int playersCount;
  late int level;
  late FinishGame onFinish;
  late int cardsCount;
  late List<MCCard> cards;
  late List<MCPlayer> players;
  late MCPlayer? activePlayer;
  late List<int> flippedCards;
  late int lifeCount;

  @override
  void initState() {
    super.initState();
    playersCount = widget.playersCount;
    level = widget.level;
    cardsCount = widget.playersCount > 1 ? 12 + ((widget.playersCount-1) * 6) : 12;
    cards = initCards();
    players = widget.playersCount > 1 ? initPlayers() : [];
    activePlayer = players.isNotEmpty ? players[0] : null;
    flippedCards = [];
    lifeCount = widget.playersCount == 1 ? 2 : 0;
  }

  List<MCCard> initCards() {
    final cardsList = <MCCard>[];
    final combinationList = {};
    for(var i = 0; i < cardsCount; i += 2){
      var chosenImage = randomImage();
      var chosenColor = randomColor();
      if (combinationList[chosenImage] != null){
        do {
          chosenColor = randomColor();
        } while (combinationList[chosenImage].contains(chosenColor));
      } else {
        combinationList[chosenImage] = [];
        combinationList[chosenImage].add(chosenColor);
      }
      var tempCard = MCCard(value: i, color: chosenColor, flipped: false, image: chosenImage, locked: false, key: GlobalKey<MCFlipCardState>());
      var tempCard2 = MCCard(value: i, color: chosenColor, flipped: false, image: chosenImage, locked: false, key: GlobalKey<MCFlipCardState>());
      cardsList.add(tempCard);
      cardsList.add(tempCard2);
    }
    cardsList.shuffle();
    return cardsList;
  }

  List<MCPlayer> initPlayers(){
    final playersList = <MCPlayer>[];
    for(var i = 0; i < playersCount; i ++){
      playersList.add(MCPlayer(id: i, points: 0, name: 'Player ${i+1}'));
    }
    return playersList;
  }

  void checkCards(cardId) {
    flippedCards.add(cardId);
    if (flippedCards.length == 2 && cards[flippedCards[0]].value == cards[flippedCards[1]].value) {
      cards[flippedCards[0]].locked = true;
      cards[flippedCards[1]].locked = true;
      setState(() {
        flippedCards = [];
      });
      if(activePlayer != null) {
        players[activePlayer!.id].setPoints(activePlayer!.points+1);
        Timer(const Duration(milliseconds: 1000), switchPlayer);
      }
    } else if (flippedCards.length == 2) {
      for (var i = 0; i < flippedCards.length; i++) {
        var id = flippedCards[i];
        Timer(const Duration(milliseconds: 600), () => {
          cards[id].key.currentState!.flipCard(),
          setState(() {
            flippedCards = [];
          }),
          if (i == 0 && playersCount == 1){
            setState(() {
              lifeCount = lifeCount-1;
            })
          }
        });
      }
      if (lifeCount == 0 && playersCount == 1) {
        Timer(const Duration(milliseconds: 450), gameOver);
      } else if (playersCount > 1) {
        Timer(const Duration(milliseconds: 1000), switchPlayer);
      }
    }
    checkFinish();
  }

  void switchPlayer() {
    if (activePlayer!.id == players.length - 1) {
      setState(() {
        activePlayer = players[0];
      });
    } else {
      setState(() {
        activePlayer = players[activePlayer!.id + 1];
      });
    }
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text(
              activePlayer!.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'It\'s your turn !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
    );
  }

  void checkFinish() {
    var allFliped = cards.where((card) => card.locked == false);
    if (allFliped.isEmpty){
      Timer(const Duration(milliseconds: 500), () => widget.onFinish(true, activePlayer));
    }
  }

  void gameOver() {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Game Over !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25.0),
              child: const Text(
                'All Lives are lost...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchingCardsPage(title: 'Matching Cards')
                          )
                      )
                    },
                    child: const Text(
                      'Restart Game',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text(
                        'Go Home',
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                    ),
                  ),
                ]
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
          child: Column(
            children: [
              (playersCount == 1)?
              Container(
                margin: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i <= 2; i++)
                      Icon(
                        (lifeCount >= i) ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 35.0,
                      )
                  ],
                ),
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    activePlayer!.name,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Text(
                      '|',
                      style: TextStyle(
                        fontSize: 37.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '${activePlayer!.points} pts',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: List.generate(cardsCount, (index) {
                  return MCFlipCard(
                    level: level,
                    key: cards[index].key,
                    card: cards[index],
                    id: index,
                    onFlip: checkCards,
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
