import 'package:flutter/material.dart';
import 'package:games_bk/models/player.dart';
import 'package:games_bk/screens/matching_cards/b_level_selection.dart';

import '../components/app_bar_header.dart';
import '../screens/matching_cards/a_players_selection.dart';
import '../screens/matching_cards/c_main_game.dart';
import '../screens/matching_cards/d_finish.dart';

class MatchingCardsPage extends StatefulWidget {
  const MatchingCardsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MatchingCardsPage> createState() => _MatchingCardsPageState();
}

class _MatchingCardsPageState extends State<MatchingCardsPage> {

  late int playersCount;
  late int level;
  late bool isFinish;
  late MCPlayer? winner;

  @override
  void initState() {
    super.initState();
    playersCount = 0;
    level = 0;
    isFinish = false;
    winner = null;
  }

  void getPlayersCount(int count) {
    setState(() {
      playersCount = count;
    });
  }

  void getLevel(int levelNumber) {
    setState(() {
      level = levelNumber;
    });
  }

  setFinish(bool finishState, MCPlayer? newWinner) {
    setState(() {
      isFinish = finishState;
      winner = newWinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(title: widget.title, showGameButton: true),
      body:(isFinish)?
        MCFinish(winner: winner):
        (playersCount == 0)?
        MCPlayerSelection(onPlayersCount: getPlayersCount):
        (level == 0)?
        MCLevelSelection(onLevelChange: getLevel):
        MCMainGame(playersCount: playersCount, level: level, onFinish: setFinish),
    );
  }
}
