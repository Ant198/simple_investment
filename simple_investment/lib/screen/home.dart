import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_investment/calculate/sticker_price.dart';
import 'package:simple_investment/provider/company_data_provider.dart';
//import 'package:simple_investment/widgets/result.dart';
//import 'package:simple_investment/servises/fetchdata.dart';
//import 'package:simple_investment/widgets/list_companies.dart';
//import 'package:simple_investment/widgets/list_companies.dart';
import 'package:simple_investment/widgets/search_field.dart';
import 'package:simple_investment/share/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _keyForm = GlobalKey<FormState>();
  final _searchCompany = TextEditingController();
  final String text = 'example';

  @override
  void dispose() {
    _searchCompany.dispose();
  }
  void handleSubmit(saveData) async {
    if (_keyForm.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: StyledText(text: 'Processing Data'))
      );
    }
    print('start');
    await saveData.fetchCompanyData(_searchCompany.text);
    //await saveData.fetchEarnings(_searchCompany.text);
    //await saveData.fetchIncomeStatement(_searchCompany.text);
    //await saveData.fetchBalanceSheet(_searchCompany.text);
    //await saveData.fetchCashFlow(_searchCompany);
    print('stage - 2');
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Form(
                      key: _keyForm,
                      child: SearchField(nameController: _searchCompany, text: 'Search',)
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async => handleSubmit(provider),
                      child: const Text('search'),
                     ),
                  )
                ],
              ),
              Consumer<CompanyDataProvider>(
                builder: (context, item, child) {
                  print(item.toString());
                  if (item.ePSStore.isEmpty) {
                    return const Text('company');
                  } else {
                    print('stage - 5');
                    print('INCOME STATEMENT - ${item.incomeStatement["annualReports"]}');
                    print('BALANCE SHEET - ${item.balanceSheet["annualReports"]}');
                    print('CASH FLOW - ${item.cashFlow["annualReports"]}');
                    print('EPS ANNUAL - ${item.ePSStore["annualEarnings"]}');
                    print('EPS QUART - ${item.ePSStore['quarterlyEarnings']}');
                    return StickerPrice(
                      incomeStatement: item.incomeStatement["annualReports"],
                      balanceSheet: item.balanceSheet["annualReports"],
                      cashFlow: item.cashFlow["annualReports"],
                      epsAnnual: item.ePSStore["annualEarnings"],
                      epsQuart: item.ePSStore['quarterlyEarnings'],
                    );
                  }
                }
              ),
            ],
          )
        ),
      ),
    );
  }
}