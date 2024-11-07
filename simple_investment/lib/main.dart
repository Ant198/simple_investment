import 'package:flutter/material.dart';
import 'package:simple_investment/screen/home.dart';
import 'package:simple_investment/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Investment',
      theme: primeTheme,
      home: const Home(),
    );
  }
}
