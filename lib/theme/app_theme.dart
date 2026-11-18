import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// One palette for the whole page, taken from the hero: warm paper, ink,
/// a mint accent for lines and highlights, and two soft glows.
class AppTheme {
  // Surfaces
  static const Color paper = Color(0xFFF7F7F4);
  static const Color paper2 = Color(0xFFEFF2EF);
  static const Color bgCream = paper; // older name, kept for the project cards
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLight = paper2;
  static const Color bgDark = paper;

  // Ink
  static const Color textBlack = Color(0xFF0A0A0A);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF5F6368);
  static const Color textLight = Color(0xFF9AA0A6);

  // Accents
  static const Color mint = Color(0xFF3FA47F);
  static const Color mintSoft = Color(0xFFE3F3EC);
  static const Color blush = Color(0xFFFFC7C7);
  static const Color lilac = Color(0xFFE4CBFF);
  static const Color accent = mint;
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentCyan = Color(0xFF00D4FF);

  // Lines
  static const Color border = Color(0xFFE3E7E4);
  static const Color borderDark = Color(0xFFCBD2CD);

  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: paper,
        colorScheme: const ColorScheme.light(
          primary: textBlack,
          secondary: mint,
          surface: bgWhite,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      );

  /// Display face used for every section title.
  static TextStyle display(double size, {Color color = textBlack}) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: FontWeight.w700,
        letterSpacing: size * -0.03,
        height: 1.04,
        color: color,
      );

  /// The italic serif used for the accent word inside a title.
  static TextStyle displayAccent(double size, {Color color = mint}) =>
      GoogleFonts.playfairDisplay(
        fontSize: size * 1.02,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        letterSpacing: -0.5,
        height: 1.04,
        color: color,
      );

  static TextStyle body({double size = 15, Color color = textGray}) =>
      GoogleFonts.inter(fontSize: size, height: 1.75, color: color);

  static TextStyle eyebrow({Color color = textLight}) => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.6,
        color: color,
      );
}
