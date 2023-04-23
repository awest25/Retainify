import 'package:flutter/material.dart';

const title = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w600, color: Color(0xff263b68));
const header1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
const header2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w300);
const header3 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const body = TextStyle(fontFamily: 'OpenSans', fontSize: 16);

final theme = ThemeData(
    fontFamily: "OpenSans",
    colorScheme: const ColorScheme(
        // primary
        primary: Color(0xff263b68),
        onPrimary: Colors.white,
        // secondary
        secondary: Color(0xffc5ffed),
        onSecondary: Color(0xff263b68),
        // background
        background: Color.fromARGB(255, 231, 234, 235),
        onBackground: Color(0xff263b68),
        // surface
        surface: Colors.white,
        onSurface: Color(0xff263b68),
        // error
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light));

final ShapeBorder curvedShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15),
);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    backgroundColor: theme.colorScheme.secondary,
    foregroundColor: theme.colorScheme.onSecondary,
    textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14));
