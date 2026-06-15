import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color bgCream = Color(0xFFF5F0E8);
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLight = Color(0xFFF0EBE1);
  static const Color textBlack = Color(0xFF0A0A0A);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  static const Color accent = Color(0xFFFF6B35);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentCyan = Color(0xFF00D4FF);
  static const Color bgDark = bgCream;
  static const Color border = Color(0xFFE5E0D8);
  static const Color borderDark = Color(0xFFCCC8C0);

  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: bgCream,
        colorScheme: const ColorScheme.light(
          primary: textBlack,
          secondary: accent,
          surface: bgWhite,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      );
}
