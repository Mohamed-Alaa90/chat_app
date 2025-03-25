import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static const Color primaryColor = Color(0xFF1E1E2C); // لون رئيسي داكن
  static const Color secondaryColor = Color(0xFFBB86FC); // لون بنفسجي مميز
  static const Color accentColor = Color(0xFF03DAC6); // لون أكوا مضيء
  static const Color backgroundColor = Color(0xFF121212); // لون الخلفية الأساسي
  static const Color cardColor = Color(0xFF1E1E2C); // لون الكروت
  static const Color textColor = Colors.white; // لون النصوص
  static const Color iconColor = Colors.white70; // لون الأيقونات

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          background: backgroundColor,
          onBackground: textColor,
          surface: cardColor,
          onSurface: textColor,
        ),
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        bottomAppBarTheme: const BottomAppBarTheme(color: backgroundColor),
        iconTheme: const IconThemeData(color: iconColor),
        cardTheme: const CardTheme(color: cardColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: textColor),
          titleTextStyle: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: textColor),
          bodyMedium: TextStyle(fontSize: 16, color: textColor.withOpacity(0.8)),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
        ),
      );
}

DarkTheme darkTheme = DarkTheme();
