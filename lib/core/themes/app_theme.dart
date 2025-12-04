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
          fontWeight: FontWeight.w800, // ExtraBold
          color: colorBlackText,
        ),
        displayMedium: GoogleFonts.lexend(
          fontWeight: FontWeight.w700, // Bold
          color: colorBlackText,
        ),
        displaySmall: GoogleFonts.lexend(
          fontWeight: FontWeight.w600, // SemiBold
          color: colorBlackText,
        ),

        // Títulos de páginas e seções
        headlineLarge: GoogleFonts.lexend(
          fontWeight: FontWeight.w700, // Bold
          color: colorBlackText,
        ),
        headlineMedium: GoogleFonts.lexend(
          fontWeight: FontWeight.w600, // SemiBold
          color: colorBlackText,
        ),
        headlineSmall: GoogleFonts.lexend(
          fontWeight: FontWeight.w500, // Medium
          color: colorBlackText,
        ),

        //Títulos de Cards e ListTiles 
        titleLarge: GoogleFonts.lexend(
          fontWeight: FontWeight.w600, // SemiBold
          color: colorBlackText,
        ),
        titleMedium: GoogleFonts.lexend(
          fontWeight: FontWeight.w500, // Medium
          color: colorBlackText,
        ),

        // Texto corrido/parágrafos 
        bodyLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w400, // Regular
          fontSize: 16,
          color: colorBlackText,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w400, // Regular
          fontSize: 14,
          color: colorBlackText,
        ),

        // Botões, Chips e Legendas
        labelLarge: GoogleFonts.roboto(
          fontWeight: FontWeight.w700, // Bold (Ideal para botões)
          fontSize: 16, 
          letterSpacing: 0.5,
        ),
        labelMedium: GoogleFonts.roboto(
          fontWeight: FontWeight.w500, // Medium
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.roboto(
          fontWeight: FontWeight.w500, // Medium
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}