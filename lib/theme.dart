import 'package:flutter/material.dart';

ThemeData get theme {
  const Color yellow_100 = Color(0xfffff9c4);
  const Color yellow_500 = Color(0xffffeb3b);
  const Color yellow_700 = Color(0xfffbc02d);
  const Color blue_500 = Color(0xff2196f3);
  const Color red_300 = Color(0xffe57373);

  return ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.light,
    primaryColor: yellow_500,
    primaryColorLight: yellow_100,
    primaryColorDark: yellow_700,
    accentColor: blue_500,
    buttonColor: blue_500,
    cardColor: yellow_500,
    errorColor: red_300,
    dividerColor: Colors.transparent,
  );
}
