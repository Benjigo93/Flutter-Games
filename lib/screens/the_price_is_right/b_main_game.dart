import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/color.dart';

typedef FinishGame = void Function(bool win);
Random rd = Random();

class TPIRMainGame extends StatefulWidget {
  const TPIRMainGame({Key? key, required this.onFinish}) : super(key: key);

  final FinishGame onFinish;

  @override
  State<TPIRMainGame> createState() => _TPRIMainGameState();
}

class _TPRIMainGameState extends State<TPIRMainGame> {

  final FocusNode _focusNode = FocusNode();

  late FinishGame onFinish;
  late int price;
  late bool win;
  late String computerGuidance;
  Timer? gameCountdownTimer;
  int countdown = 10;

  @override
  void initState() {
    super.initState();
    price = rd.nextInt(100000);
    win = false;
    computerGuidance = '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      startTimer();
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  void startTimer() {
    gameCountdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countdown == 1) {
        setState(() {
          timer.cancel();
        });
        FocusScope.of(context).requestFocus(FocusNode());
        Timer(const Duration(milliseconds: 150), () => widget.onFinish(win));
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void checkPrice(int playerPrice) {
    if (playerPrice == price) {
      setState(() {
        win = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());
      Timer(const Duration(milliseconds: 150), () => widget.onFinish(win));
    } else if (playerPrice > price) {
      setState(() {
        computerGuidance = 'Less';
      });
    } else {
      setState(() {
        computerGuidance = 'More';
      });
    }
  }

  @override
  void dispose() {
    if(gameCountdownTimer != null) {
      gameCountdownTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: const ThemeColor().lightBrown, spreadRadius: 5),
            ],
          ),
          height: 80,
          width: 80,
          child: Center(
            child: Text(
              '$countdown',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const ThemeColor().darkBrown,
                fontSize: 45.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: TextField(
            focusNode: _focusNode,
            textAlign: TextAlign.center,
            style:const TextStyle(
                fontSize: 25.0
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Price',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            autofocus: true,
            onSubmitted: (value) {
              if (double.tryParse(value) != null) {
                checkPrice(int.parse(value));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Please choose a correct price',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          )
                      ),
                      backgroundColor: Colors.red.withOpacity(0.7),
                      duration: const Duration(seconds: 1),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    )
                );
              }
            },
          ),
        ),
        (computerGuidance != '')?
          Container(
            margin: const EdgeInsets.only(top: 35.0, bottom: 20.0),
            child: Text(
              computerGuidance,
              style: const TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ):
          Container(),
      ],
    );
  }
}
