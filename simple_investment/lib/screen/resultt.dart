import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_investment/calculate/sticker_price.dart';
import 'package:simple_investment/provider/company_data_provider.dart';

class Resultt extends StatelessWidget {
  const Resultt({super.key});

  @override
  Widget build(BuildContext context) {
/*
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: DataTable(
          columns: const[
            DataColumn(label: Text('')),
            DataColumn(label: Text('1-year')),
            DataColumn(label: Text('5-years')),
            DataColumn(label: Text('10-year')),
          ],
          rows: const[
            DataRow(cells: [
              DataCell(Text('Sales Rate')),
              DataCell(Text('value 1')),
              DataCell(Text('value 2')),
              DataCell(Text('value 3')),
            ]),
          ],
        ),
      ),
    );
*/
  return Scaffold(
    appBar: AppBar(title: const Text('Result')),
    body: Consumer<CompanyDataProvider>(
                  builder: (context, item, child) {
                    if (item.ePSStore.isEmpty) {
                      return const Text('company');
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
  );
  }
}