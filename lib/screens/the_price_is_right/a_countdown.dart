import 'dart:async';

import 'package:flutter/material.dart';

import '../../themes/color.dart';

typedef CountdownFinished = void Function(int screen);

class TPIRCountdown extends StatefulWidget {
  const TPIRCountdown({Key? key, required this.onCountdownFinished}) : super(key: key);

  final CountdownFinished onCountdownFinished;

  @override
  State<TPIRCountdown> createState() => _TPIRCountdownState();
}

class _TPIRCountdownState extends State<TPIRCountdown> {

  late CountdownFinished onCountdownFinished;
  Timer? countdownTimer;
  int countdown = 6;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if(countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countdown == 1) {
        setState(() {
          timer.cancel();
        });
        widget.onCountdownFinished(1);
      } else {
        setState(() {
          countdown--;
        });
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          child: const Text(
            'Rules',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'You have 25 seconds to make as many proposals as you wish between \n100 and 100 000.\n '
                'Each time being guided by the computer which tells you whether '
                'the amount you have given is more or less expensive than the real price. '
                'If the right price is found within this time, you win the game.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27.0,
            ),
          ),
        ),
        (countdown > 5)?
        AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: (countdown > 5) ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
          ),
        ):
        Container(),
        AnimatedOpacity(
          opacity: (countdown <= 5) ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0),
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
        )
      ],
    );
  }
}
