import 'package:flutter/material.dart';
import 'package:simple_investment/models/search_field.dart';
import 'package:simple_investment/share/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _keyForm = GlobalKey<FormState>();
  final _searchCompany = TextEditingController();

  @override
  void dispose() {
    _searchCompany.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle(text: 'Simple Investment',),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              Form(
                key: _keyForm,
                child: SearchField(nameController: _searchCompany, text: 'Search',)),
            ],
          )
        ),
      ),
    );
  }
}