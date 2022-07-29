import 'package:flutter/material.dart';
import '../components/mc_card.dart';

class MCCard {
   int value;
   Color color;
   bool flipped;
   String image;
   bool locked;
   GlobalKey<MCFlipCardState> key;

   MCCard({
    required this.value,
    required this.color,
    required this.flipped,
    required this.image,
    required this.locked,
    required this.key,
  });

  void setFlipped(bool newFlipped){
    flipped = newFlipped;
  }

  void setLocked(bool newLocked){
    locked = newLocked;
  }

  void setKey(GlobalKey<MCFlipCardState> newKey){
    key = newKey;
  }

  String get printData => 'value: $value, flipped: $flipped, locked: $locked, image: $image, color: $color, key: $key';
}