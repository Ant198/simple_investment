import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CompanyDataProvider extends ChangeNotifier {
  late Map<String, dynamic> _ePSStore = {};
  late Map<String, dynamic> _incomeStatement = {};
  late Map<String, dynamic> _balanceSheet = {};
  late Map<String, dynamic> _cashFlow = {};

  Map<String, dynamic> get ePSStore => _ePSStore;
  Map<String, dynamic> get incomeStatement => _incomeStatement;
  Map<String, dynamic> get balanceSheet => _balanceSheet;
  Map<String, dynamic> get cashFlow => _cashFlow;

  Future<void> fetchCompanyData(String ticker) async {
    String apiKey = 'XSEM76YOZ2K24533';
    String symbol = ticker;
    String urlEarnings = 'https://www.alphavantage.co/query?function=EARNINGS&symbol=$symbol&apikey=$apiKey';
    String urlIncomeStatement = 'https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=$symbol&apikey=$apiKey';
    String urlBalanceSheet = 'https://www.alphavantage.co/query?function=BALANCE_SHEET&symbol=$symbol&apikey=$apiKey';
    String urlCashFlow = 'https://www.alphavantage.co/query?function=CASH_FLOW&symbol=$symbol&apikey=$apiKey';
    
    final responses = await Future.wait([
      http.get(Uri.parse(urlEarnings)),
      http.get(Uri.parse(urlIncomeStatement)),
      http.get(Uri.parse(urlBalanceSheet)),
      http.get(Uri.parse(urlCashFlow)),
    ]);

    if(responses[0].statusCode == 200) {
      _ePSStore = convert.jsonDecode(responses[0].body);
      notifyListeners();
    } else {
      print('error');
    }
    if(responses[1].statusCode == 200) {
      _incomeStatement = convert.jsonDecode(responses[1].body);
      notifyListeners();
    } else {
      print('error');
    }
    if(responses[2].statusCode == 200) {
      _balanceSheet = convert.jsonDecode(responses[2].body);
      notifyListeners();
    } else {
      print('error');
    }
    if(responses[3].statusCode == 200) {
      _cashFlow = convert.jsonDecode(responses[3].body);
      notifyListeners();
    } else {
      print('error');
    }
  }
}