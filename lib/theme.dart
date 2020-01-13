import 'package:flutter/material.dart';

ThemeData get theme {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xffffeb3b),
    primaryColorLight: Color(0xfffff9c4),
    primaryColorDark: Color(0xfffbc02d),
    accentColorBrightness: Brightness.light,
    accentColor: Color(0xff448aff),
    dividerColor: Color(0xffbdbdbd),
    iconTheme: IconThemeData(color: Color(0xff212121)),
  );
}
