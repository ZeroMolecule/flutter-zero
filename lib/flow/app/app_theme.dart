import 'package:flutter/material.dart';
import 'package:flutter_zero/gen/colors.gen.dart';

class AppTheme with ChangeNotifier {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  late final buttonPadding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 12,
  );
  late final buttonPaddingSmall = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 4,
  );
  late final colors = ColorName;

  late final TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 27 / 18,
      color: ColorName.text,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      color: ColorName.text,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 21 / 14,
      color: ColorName.text,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 21 / 14,
      color: ColorName.text,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 21 / 14,
      color: ColorName.text,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      color: ColorName.text,
    ),
    button: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 24 / 16,
      color: ColorName.white,
    ),
  );

  late final ThemeData data = ThemeData(
    primarySwatch: Colors.amber,
    textTheme: textTheme,
  );
}
