import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_investment/calculate/sticker_price.dart';
import 'package:simple_investment/provider/company_data_provider.dart';

class Result extends StatefulWidget {
  const Result({required this.ticker, super.key});
  final String ticker;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.ticker)),
      body: Align(
        child: Consumer<CompanyDataProvider>(
          builder: (context, item, child) {
            if (item.ePSStore.isEmpty) {
              return const Text('Not Data');
            } else {
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
      ),
    );
  }
}