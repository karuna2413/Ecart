import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow.shade800);

ThemeData themedata = ThemeData(
  colorScheme: kColorScheme,
  useMaterial3: true,
  fontFamily:'Metropolis',
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white),
  ),
);



