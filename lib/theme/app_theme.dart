import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const green = Color(0xFF58CC02);
  static const greenDark = Color(0xFF46A302);
  static const greenSoft = Color(0xFFD7FFB8);
  static const blue = Color(0xFF1CB0F6);
  static const blueDark = Color(0xFF1899D6);
  static const orange = Color(0xFFFF9600);
  static const red = Color(0xFFFF4B4B);
  static const purple = Color(0xFFCE82FF);
  static const yellow = Color(0xFFFFC800);
  static const ink = Color(0xFF3C3C3C);
  static const muted = Color(0xFF777777);
  static const line = Color(0xFFE5E5E5);
  static const cream = Color(0xFFFFFBF0);
  static const sky = Color(0xFFDDFFFF);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.light,
      primary: AppColors.green,
      secondary: AppColors.blue,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  return base.copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.nunito(
        fontWeight: FontWeight.w800,
        fontSize: 20,
        color: AppColors.ink,
      ),
      iconTheme: const IconThemeData(color: AppColors.ink),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.greenDark, width: 0),
        ),
        textStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w800,
          fontSize: 16,
          letterSpacing: 0.4,
        ),
      ),
    ),
    cardTheme: const CardTheme(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(color: AppColors.line, width: 2),
      ),
    ),
  );
}
