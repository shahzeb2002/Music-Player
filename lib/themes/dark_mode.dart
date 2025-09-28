import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey[900],   // 👈 tile background for dark mode

  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white, // text/icons
    secondary: Colors.grey[500]!, // Spotify green for highlights
    inversePrimary: Colors.grey, // secondary text
  ),

);