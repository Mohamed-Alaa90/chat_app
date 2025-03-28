import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  // 🎨 لوحة ألوان حديثة
  static const Color primaryColor = Color(0xFF1F2937); // لون رئيسي داكن أنيق
  static const Color secondaryColor = Color(0xFF374151); // لون ثانوي رمادي غامق
  static const Color accentColor = Color(0xFF4ADE80); // لون أكوا أخضر مشرق
  static const Color backgroundColor = Color(0xFF111827); // خلفية سوداء مزرقّة
  static const Color surfaceColor = Color(0xFF1E293B); // لون الكروت والعناصر
  static const Color textColor = Color(0xFFE5E7EB); // لون النصوص رمادي فاتح
  static const Color iconColor = Color(0xFF9CA3AF); // لون الأيقونات رمادي فاتح

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true, // ✅ دعم Material 3
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
          background: backgroundColor,
          onBackground: textColor,
          surface: surfaceColor,
          onSurface: textColor,
          tertiary: accentColor,
        ),
        fontFamily: GoogleFonts.manrope().fontFamily, // ✅ خط أنيق وحديث

        // ✅ تخصيص الـ AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 3,
          iconTheme: IconThemeData(color: textColor),
          titleTextStyle: GoogleFonts.manrope(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        // ✅ تخصيص الأزرار
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            textStyle: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),

        // ✅ تخصيص النصوص
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.manrope(fontSize: 18, color: textColor),
          bodyMedium: GoogleFonts.manrope(fontSize: 16, color: textColor.withOpacity(0.8)),
          titleLarge: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),

        // ✅ تخصيص الكروت
        cardTheme: CardTheme(
          color: surfaceColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // ✅ تخصيص الـ Bottom App Bar
        bottomAppBarTheme: const BottomAppBarTheme(
          color: surfaceColor,
          elevation: 3,
        ),
      );
}

DarkTheme darkTheme = DarkTheme();
