import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_investment/provider/company_data_provider.dart';
//import 'package:simple_investment/widgets/result.dart';
//import 'package:simple_investment/servises/fetchdata.dart';
//import 'package:simple_investment/widgets/list_companies.dart';
//import 'package:simple_investment/widgets/list_companies.dart';
//import 'package:simple_investment/widgets/search_field.dart';
import 'package:simple_investment/share/styled_text.dart';
import 'package:simple_investment/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchCompany = TextEditingController();
  final String text = 'example';
  @override
  void dispose() {
    _searchCompany.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CompanyDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle(text: 'Simple Investment',),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              Align(
                child: SearchField(
                  nameController: _searchCompany,
                  text: 'Search',
                  provider: provider
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}