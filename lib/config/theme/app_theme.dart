import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme()=>ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates().copyWith(fontSize: 30),
      titleMedium: GoogleFonts.montserratAlternates().copyWith(fontSize: 20),
      titleSmall: GoogleFonts.montserratAlternates().copyWith(fontSize: 17, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.montserratAlternates().copyWith(fontSize: 17),

    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(GoogleFonts.montserratAlternates().copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
        backgroundColor: WidgetStatePropertyAll(Color(0xFFB71C1C)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(30)))
      )
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFB71C1C),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Color(0xFFB71C1C),
        iconColor: Colors.black,
        textStyle:TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
      )
    )
  );
}