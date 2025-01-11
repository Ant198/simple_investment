import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_investment/provider/company_data_provider.dart';
import 'package:simple_investment/screen/home.dart';
import 'package:simple_investment/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CompanyDataProvider(),
      child: const MainApp(),
    )
  );
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
