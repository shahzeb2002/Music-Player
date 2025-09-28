import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  cardColor: Colors.grey[300],   //  tile background for dark mode

  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Color(0xFF1DB954),
    inversePrimary: Colors.grey
    // background: Colors.grey.shade300,
    // primary: Colors.grey.shade500,
    // secondary: Colors.grey.shade200,
    // inversePrimary: Colors.grey.shade900
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  ),

);