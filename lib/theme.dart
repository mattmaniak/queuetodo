import 'package:flutter/material.dart';

ThemeData get theme {
  const Color yellow_100 = Color(0xfffff9c4);
  const Color yellow_500 = Color(0xffffeb3b);
  const Color yellow_700 = Color(0xfffbc02d);
  const Color blue_400 = Color(0xff42a5f5);
  const Color red_300 = Color(0xffe57373);

  return ThemeData(
    primaryColor: yellow_500,
    primaryColorLight: yellow_100,
    primaryColorDark: yellow_700,
    // brightness: Brightness.light,
    accentColor: blue_400,
    accentColorBrightness: Brightness.light,
    buttonColor: blue_400,
    dividerColor: Colors.transparent,
    errorColor: red_300,
    cardColor: yellow_500,
  );
}
