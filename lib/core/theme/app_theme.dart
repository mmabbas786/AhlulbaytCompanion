import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        primaryColor: AppColors.primaryTeal,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryTeal,
          secondary: AppColors.islamicGold,
          surface: AppColors.darkCard,
          error: AppColors.error,
          onPrimary: AppColors.textPrimary,
          onSecondary: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,
          onError: AppColors.textPrimary,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        useMaterial3: true,
      );

  static ThemeData get amoledTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.amoledBlack,
        primaryColor: AppColors.primaryTeal,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryTeal,
          secondary: AppColors.islamicGold,
          surface: AppColors.amoledBlack,
          error: AppColors.error,
          onPrimary: AppColors.textPrimary,
          onSecondary: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,
          onError: AppColors.textPrimary,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
        useMaterial3: true,
      );

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        primaryColor: AppColors.primaryTeal,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryTeal,
          secondary: AppColors.islamicGold,
          surface: Colors.white,
          error: AppColors.error,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.textDark,
          onError: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: AppColors.textDark,
          displayColor: AppColors.textDark,
        ),
        useMaterial3: true,
      );

  static TextStyle getLocalizedTextStyle({
    required String languageCode,
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Color color = Colors.white,
  }) {
    switch (languageCode) {
      case 'ar':
        return GoogleFonts.scheherazadeNew(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case 'ur':
      case 'fa':
        return GoogleFonts.notoNastaliqUrdu(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      case 'bn':
        return GoogleFonts.notoSansBengali(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
      default:
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        );
    }
  }
}