import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myblue = Color(0xff95AEEE);
const Color light_bg = Color(0xffF0F2F5);
const Color dark_bg = Color(0xff121212);
const Color myRed = Color(0xffFF6464);
const Color myGreen = Color(0xffE6DA73);

class Themes {
  static final light = ThemeData(
    scaffoldBackgroundColor: Color(0xffF0F2F5),
    brightness: Brightness.light,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: Color(0xff121212), 
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
    brightness: Brightness.dark,
  );
}
