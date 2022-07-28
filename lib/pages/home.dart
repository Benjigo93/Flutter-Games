import 'package:flutter/material.dart';

import '../components/app_bar_header.dart';
import '../components/text_with_stroke.dart';
import '../themes/color.dart';
import 'matching_cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHeader(title: 'Flutter Games', showHomeButton: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'CHOOSE A GAME :',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: const ThemeColor(opacity: 1).darkBrown,
                  ),
                )
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                height: 130,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: const ThemeColor(opacity: 1).darkBrown,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: const ThemeColor(opacity: 0.8).lightBrown,
                  child: InkWell(
                    splashColor: Colors.brown.withAlpha(80),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchingCardsPage(title: 'Matching Cards'))
                      );
                    },
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Center(
                        child: TextWithStroke(
                            title:'Matching Cards',
                            size: 35,
                            strokeColor: const ThemeColor(opacity: 1.0).darkBrown,
                            color: Colors.white,
                            strokeWidth: 4
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                height: 130,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: const ThemeColor(opacity: 1).darkBrown,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: const ThemeColor(opacity: 0.8).lightBrown,
                  child: InkWell(
                    splashColor: Colors.brown.withAlpha(80),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatchingCardsPage(title: 'Matching Cards'))
                      );
                    },
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: Center(
                        child: TextWithStroke(
                            title:'The Price Is Right',
                            size: 35,
                            strokeColor: const ThemeColor(opacity: 1.0).darkBrown,
                            color: Colors.white,
                            strokeWidth: 4
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}