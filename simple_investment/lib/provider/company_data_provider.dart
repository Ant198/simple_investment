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

    for (var response in responses) {
      if(response.statusCode == 200) {
        if(_ePSStore.isEmpty) {
          _ePSStore = convert.jsonDecode(response.body);
          notifyListeners();
          continue;
        } else if(_incomeStatement.isEmpty) {
          _incomeStatement = convert.jsonDecode(response.body);
          notifyListeners();
          continue;
        } else if(_balanceSheet.isEmpty) {
          _balanceSheet = convert.jsonDecode(response.body);
          notifyListeners();
          continue;
        } else {
          _cashFlow = convert.jsonDecode(response.body);
          notifyListeners();
        }
      } else {
        print('error hello');
      }
    }
  }

/*
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

  */
  
}
  /*
   fcf = operatingCashFlow - caEx
  */
