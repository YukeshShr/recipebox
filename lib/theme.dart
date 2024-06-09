import 'package:flutter/material.dart';

var appTheme = ThemeData(
  fontFamily: 'Inter',
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
  ),
  iconTheme: const IconThemeData(color: Color(0xFFFAFAFA)),
);
