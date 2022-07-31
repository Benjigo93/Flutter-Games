import 'package:flutter/material.dart';
import 'package:games_bk/components/text_with_stroke.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../pages/matching_cards.dart';
import '../pages/the_price_is_right.dart';


class AppBarHeader extends StatelessWidget with PreferredSizeWidget{
  const AppBarHeader({Key? key, required this.title, required this.showGameButton, required this.parent,}) : super(key: key);

  final String title;
  final bool showGameButton;
  final String parent;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: (showGameButton)?
      IconButton(
        iconSize: 30,
        splashColor: Colors.brown.withAlpha(80),
        splashRadius: 28,
        icon: const DecoratedIcon(
          icon: Icon(Icons.home_filled, color: Colors.white),
          decoration: IconDecoration(border: IconBorder(width: 2)),
        ),
        tooltip: 'Go Back Home',
        onPressed: () => {
          FocusScope.of(context).requestFocus(FocusNode()),
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Exit Game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
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
                      'Are you sure you want to exit this game ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
                          child: Text(
                            'No',
                            style: TextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
                          child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.w600,
                              )
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        },
      ):Container(),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: TextWithStroke(
            title: title,
            color: Colors.white,
            strokeColor: Colors.black,
            size: 35,
            strokeWidth: 2
        ),
      ),
      actions: [
        (showGameButton)?
        IconButton(
          iconSize: 30,
          splashColor: Colors.brown.withAlpha(80),
          splashRadius: 28,
          icon: const DecoratedIcon(
            icon: Icon(Icons.refresh, color: Colors.white),
            decoration: IconDecoration(border: IconBorder(width: 2)),
          ),
          tooltip: 'Restart Game',
          onPressed: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Restart Game',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
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
                        'Are you sure you want to restart a game ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      if (parent == 'mc') {
                                        return const MatchingCardsPage(title: 'Matching Cards');
                                      } else if (parent == 'tpir') {
                                        return const TPIRPage(title: 'The Price Is Right');
                                      } else {
                                        return const MatchingCardsPage(title: 'Matching Cards');
                                      }
                                    }
                                )
                            )
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
                            child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          },
        ):Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}