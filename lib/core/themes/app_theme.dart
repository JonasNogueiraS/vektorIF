import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF22a0d7);
  static const Color primaryColor = Color(0xFF5046FA);
  static const Color colorBackground = Color(0xFFEBEBEB);
  static const Color colorBlackText = Color(0xFF020B0C);
  static const Color colorGrayText = Color(0xFFA1A1A1);
  static const Color colorWhiteText = Color(0xFFF2F2F2);
  static const Color colorLogo = Color(0xFF4F378A);
  static const Color colorButtonCancel = Color(0xFFFF0808);
  static const Color colorButtons = Color(0xFF006FFD);
  static const Color colorButtonDisable = Color(0xFFD2D6DB);
  static const Color colorButtonFilterDisable = Color(0xFFD8E7FF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryColor,
        surface: colorBackground,
        onSurface: colorBlackText,
      ),

      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: GoogleFonts.lexend(
          fontWeight: FontWeight.bold, color: colorBlackText
        ),

        displayMedium: GoogleFonts.lexend(
          fontWeight: FontWeight.bold, color: colorBlackText
        ),

        displaySmall: GoogleFonts.lexend(
          fontWeight: FontWeight.bold, color: colorBlackText
        ),

        headlineLarge: GoogleFonts.lexend(
          fontWeight: FontWeight.w800, color: colorBlackText
        ),
        headlineMedium: GoogleFonts.lexend(
          fontWeight: FontWeight.w600, color: colorBlackText
        ),
        headlineSmall: GoogleFonts.lexend(
          fontWeight: FontWeight.w500, color: colorBlackText
        ),

        labelLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w900, fontSize: 18,
        ),
        labelMedium: GoogleFonts.roboto(
         fontSize: 16, fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
