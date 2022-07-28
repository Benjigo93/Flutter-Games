import 'package:flutter/material.dart';

import '../components/app_bar_header.dart';

class MatchingCardsPage extends StatefulWidget {
  const MatchingCardsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MatchingCardsPage> createState() => _MatchingCardsPageState();
}

class _MatchingCardsPageState extends State<MatchingCardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(title: widget.title, showHomeButton: true),
      body: Container(),
    );
  }
}
