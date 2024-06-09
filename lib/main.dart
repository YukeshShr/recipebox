import 'package:flutter/material.dart';
import 'package:recipebox/homepage.dart';
import 'package:recipebox/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage());
  }
}
