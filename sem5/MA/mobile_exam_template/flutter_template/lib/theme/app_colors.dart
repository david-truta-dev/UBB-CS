import 'dart:ui';

import 'package:flutter/material.dart';

Map<int, Color> _color = {
  50: const Color.fromRGBO(63,90,166, .1),
  100: const Color.fromRGBO(63,90,166, .2),
  200: const Color.fromRGBO(63,90,166, .3),
  300: const Color.fromRGBO(63,90,166, .4),
  400: const Color.fromRGBO(63,90,166, .5),
  500: const Color.fromRGBO(63,90,166, .6),
  600: const Color.fromRGBO(63,90,166, .7),
  700: const Color.fromRGBO(63,90,166, .8),
  800: const Color.fromRGBO(63,90,166, .9),
  900: const Color.fromRGBO(63,90,166, 1),
};

class AppColors {
  static const MaterialColor primarySwatch = Colors.teal;
  static const Color primaryColor = Colors.teal;
  static const Color backgroundColor = Color(0xFF1a1a1a);
}
