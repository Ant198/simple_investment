import 'package:flutter/material.dart';
import 'package:simple_investment/provider/company_data_provider.dart';
import 'package:simple_investment/widgets/result.dart';

class StickerPrice extends StatelessWidget {
  const StickerPrice({required this.data, super.key});
  final CompanyDataProvider data;

  double getTrailingEps() {
    double fourthQuart = double.parse(data.ePSStore['quarterlyEarnings'][0]['reportedEPS']);
    double thirdQuart = double.parse(data.ePSStore['quarterlyEarnings'][1]['reportedEPS']);
    double secondQuart = double.parse(data.ePSStore['quarterlyEarnings'][2]['reportedEPS']);
    double firstQuart = double.parse(data.ePSStore['quarterlyEarnings'][3]['reportedEPS']);
    double res = firstQuart + secondQuart + thirdQuart + fourthQuart;

    print('$res + $firstQuart + $secondQuart + $thirdQuart + $fourthQuart');
    return res;
  }

  double getRoic() {
    double netIncome = double.parse(data.incomeStateent["annualReports"][0]["netIncome"]);
    double totalDebt = double.parse(data.balanceSheet["annualReports"][0]["longTermDebtNoncurrent"])
                    + double.parse(data.balanceSheet["annualReports"][0]["shortTermDebt"]);
    double equity = double.parse(data.balanceSheet["annualReports"][0]["totalAssets"])
                  - double.parse(data.balanceSheet["annualReports"][0]["totalLiabilities"]);
  }
  @override
  Widget build(BuildContext context) {
    return Result(earnings: getTrailingEps());
  }
}