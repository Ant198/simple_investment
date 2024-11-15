import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CompanyDataProvider extends ChangeNotifier {
  late Map<String, dynamic> _ePSStore = {};
  Map<String, dynamic> get ePSStore => _ePSStore;
  set ePSStore(Map<String, dynamic> value) {
    _ePSStore = value;
    notifyListeners();
  }
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
  /*
   fcf = operatingCashFlow - caEx
  */
}