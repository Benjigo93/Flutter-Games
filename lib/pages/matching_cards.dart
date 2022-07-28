import 'package:flutter/material.dart';

import '../components/app_bar_header.dart';
import '../screens/matching_cards/a_players_selection.dart';
import '../screens/matching_cards/b_main_game.dart';

class MatchingCardsPage extends StatefulWidget {
  const MatchingCardsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MatchingCardsPage> createState() => _MatchingCardsPageState();
}

class _MatchingCardsPageState extends State<MatchingCardsPage> {

  late int playersCount;

  @override
  void initState() {
    super.initState();
    playersCount = 0;
  }

  void getPlayersCount(int count) {
    setState(() {
      playersCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(title: widget.title, showGameButton: true),
      body: (playersCount == 0)?
        MCPlayerSelection(mapPlayersCount: getPlayersCount):
        MCMainGame(playersCount: playersCount),
    );
  }
}
