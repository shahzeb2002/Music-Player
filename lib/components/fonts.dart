import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // AppBar text style (dynamic with theme)
  static TextStyle appBar(BuildContext context) {
    return GoogleFonts.aboreto(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  // Headings (dynamic with theme)
  static TextStyle heading(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onBackground,
    );
  }

  // Subheadings (dynamic with theme)
  static TextStyle subheading(BuildContext context) {
    return GoogleFonts.roboto(
      fontSize: 12,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
  }
}
