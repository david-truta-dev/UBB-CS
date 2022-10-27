import 'package:flutter/material.dart';
import 'package:my_albums_app/theming/text_styles.dart';

import 'colors.dart';

final ThemeData myThemeData = ThemeData(
  fontFamily: 'Nunito',
  textTheme: const TextTheme(
    titleSmall: titleSmallTextStyle,
    headlineSmall: headlineSmallTextStyle,
    headlineMedium: headlineMediumTextStyle,
    headlineLarge: headlineLargeTextStyle,
    labelSmall: labelSmallTextStyle,
    labelMedium: labelMediumTextStyle,
    titleMedium: titleMediumTextStyle,
  ),
  primaryColor: primaryColor,
  colorScheme: ColorScheme(
    surface: surface,
    primary: primaryColor,
    onPrimary: onPrimary,
    secondary: secondary,
    background: background,
    onSurface: onSurface,
    onError: onError,
    error: error,
    onBackground: onBackground,
    onSecondary: onSecondary,
    brightness: Brightness.light,
    outline: borderColor,
    primaryContainer: primaryColor,
    onPrimaryContainer: unselectedTabBarLabel,
  ),
);
