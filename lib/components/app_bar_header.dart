import 'package:flutter/material.dart';
import 'package:games_bk/components/text_with_stroke.dart';
import 'package:icon_decoration/icon_decoration.dart';

import '../pages/matching_cards.dart';


class AppBarHeader extends StatelessWidget with PreferredSizeWidget{
  const AppBarHeader({Key? key, required this.title, required this.showGameButton}) : super(key: key);

  final String title;
  final bool showGameButton;

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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Exit Game',
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
            content: const Text(
              'Are you sure you want to exit this game ?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 23.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 23.0,
                  )
                ),
              ),
            ],
          ),
        ),
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
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Restart Game',
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
              content: const Text(
                'Are you sure you want to restart a game ?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 23.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context),
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MatchingCardsPage(title: 'Matching Cards'))
                    )
                  },
                  child: const Text(
                      'Yes',
                      style: TextStyle(
                        fontSize: 23.0,
                      )
                  ),
                ),
              ],
            ),
          ),
        ):Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}