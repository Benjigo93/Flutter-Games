import 'dart:math';

Random rd = Random();

List<String> images = [
  'assets/images/cards/bear.png',
  'assets/images/cards/bison.png',
  'assets/images/cards/cougar.png',
  'assets/images/cards/fox.png',
  'assets/images/cards/hare.png',
  'assets/images/cards/lynx.png',
  'assets/images/cards/moose.png',
  'assets/images/cards/pig.png',
  'assets/images/cards/polar-bear.png',
  'assets/images/cards/raccoon.png',
];

String randomImage () {
  return images[rd.nextInt(images.length-1)];
}

