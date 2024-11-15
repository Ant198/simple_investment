import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<void> fetchEarnings(String ticker, provider) async {
  String apiKey = 'XSEM76YOZ2K24533';
  String symbol = ticker;
  String url = 'https://www.alphavantage.co/query?function=EARNINGS&symbol=$symbol&apikey=$apiKey';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    provider.ePSStore = jsonResponse['annualEarnings'];
  }
}