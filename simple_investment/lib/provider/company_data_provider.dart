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

  Future<void> fetchEarnings(String ticker) async {
    String apiKey = 'XSEM76YOZ2K24533';
    String symbol = ticker;
    String url = 'https://www.alphavantage.co/query?function=EARNINGS&symbol=$symbol&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _ePSStore = jsonResponse;
      notifyListeners();
    }
  }

  Future<void> fetchIncomeStatement(String ticker) async {
    String apiKey = 'XSEM76YOZ2K24533';
    String symbol = ticker;
    String url = 'https://www.alphavantage.co/query?function=INCOME_STATEMENT&symbol=$symbol&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _incomeStatement = jsonResponse;
      notifyListeners();
    }
  }

  Future<void> fetchBalanceSheet(String ticker) async {
    String apiKey = 'XSEM76YOZ2K24533';
    String symbol = ticker;
    String url = 'https://www.alphavantage.co/query?function=BALANCE_SHEET&symbol=$symbol&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _balanceSheet = jsonResponse;
      notifyListeners();
    }
  }

  Future<void> fetchCashFlow(String ticker) async {
    String apiKey = 'XSEM76YOZ2K24533';
    String symbol = ticker;
    String url = 'https://www.alphavantage.co/query?function=CASH_FLOW&symbol=$symbol&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _cashFlow = jsonResponse;
      notifyListeners();
    }
  }
}
  /*
   fcf = operatingCashFlow - caEx
  */
