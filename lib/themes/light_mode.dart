import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  cardColor: Colors.grey[300],   //  tile background for dark mode

  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.grey.shade600,
    inversePrimary: Colors.grey

  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  ),

);