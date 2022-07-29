import 'package:flutter/material.dart';

import '../../components/text_with_stroke.dart';
import '../../models/level.dart';
import '../../themes/color.dart';

typedef ChangeLevel = void Function(int count);

class MCLevelSelection extends StatelessWidget {
  const MCLevelSelection({Key? key, required this.onLevelChange}) : super(key: key);

  final ChangeLevel onLevelChange;

  @override
  Widget build(BuildContext context) {
    List<MCLevel> levels = [
      MCLevel(value: 4, label: 'Easy'),
      MCLevel(value: 3, label: 'Normal'),
      MCLevel(value: 2, label: 'Hard'),
      MCLevel(value: 1, label: 'Extreme'),
    ];

    return Center(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: const Text(
                    'Choose the level',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600
                    ),
                  )
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for(var level in levels )
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      height: 80,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: const ThemeColor().darkBrown,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: const ThemeColor(opacity: 0.8).lightBrown,
                        child: InkWell(
                          splashColor: Colors.brown.withAlpha(80),
                          onTap: () {
                            onLevelChange(level.value);
                          },
                          child: SizedBox(
                            width: 200,
                            height: 100,
                            child: Center(
                              child: TextWithStroke(
                                  title: level.label,
                                  size: 35,
                                  strokeColor: const ThemeColor().darkBrown,
                                  color: Colors.white,
                                  strokeWidth: 2.5
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
