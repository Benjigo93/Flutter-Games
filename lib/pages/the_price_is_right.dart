import 'package:flutter/material.dart';

import '../components/app_bar_header.dart';
import '../screens/the_price_is_right/a_countdown.dart';
import '../screens/the_price_is_right/b_main_game.dart';
import '../screens/the_price_is_right/c_finish.dart';

class TPIRPage extends StatefulWidget {
  const TPIRPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TPIRPage> createState() => _TPIRPageState();
}

class _TPIRPageState extends State<TPIRPage> {

  late int screen;
  late bool win;

  @override
  void initState() {
    super.initState();
    screen = 0;
    win = false;
  }

  void changeScreen(int newScreen){
    setState(() {
      screen = newScreen;
    });
  }

  void finishGame(bool isWin){
    setState(() {
      win = isWin;
    });
    changeScreen(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(title: widget.title, showGameButton: true, parent: 'tpir'),
      body:Center(
          child: (screen == 0)?
          TPIRCountdown(onCountdownFinished: changeScreen):
          (screen == 1)?
          TPIRMainGame(onFinish: finishGame,):
          TPIRFinish(win: win),
      ),
    );
  }
}
