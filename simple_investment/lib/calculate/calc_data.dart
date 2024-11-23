import 'package:flutter/material.dart';
import 'package:simple_investment/widgets/result.dart';

class StickerPrice extends StatelessWidget {
  const StickerPrice({
    required this.incomeStatement, 
    required this.balanceSheet,
    required this.cashFlow,
    required this.epsAnnual,
    required this.epsQuart,
    super.key});

  final List<Map<String, dynamic>> incomeStatement;
  final List<Map<String, dynamic>> balanceSheet;
  final List<Map<String, dynamic>> cashFlow;
  final List<Map<String, dynamic>> epsAnnual;
  final List<Map<String, dynamic>> epsQuart;

  double getTrailingEps() {
    double fourthQuart = double.parse(epsQuart[0]['reportedEPS']);
    double thirdQuart = double.parse(epsQuart[1]['reportedEPS']);
    double secondQuart = double.parse(epsQuart[2]['reportedEPS']);
    double firstQuart = double.parse(epsQuart[3]['reportedEPS']);
    double res = firstQuart + secondQuart + thirdQuart + fourthQuart;

    print('$res + $firstQuart + $secondQuart + $thirdQuart + $fourthQuart');
    return res;
  }

  double getRoic() {
    List <double> listOfRoic = [];

    double netIncome = double.parse(data.incomeStatement["annualReports"][0]["netIncome"]);
    double totalDebt = double.parse(data.balanceSheet["annualReports"][0]["longTermDebtNoncurrent"])
                    + double.parse(data.balanceSheet["annualReports"][0]["shortTermDebt"]);
    double equity = double.parse(data.balanceSheet["annualReports"][0]["totalAssets"])
                  - double.parse(data.balanceSheet["annualReports"][0]["totalLiabilities"]);
    return netIncome / (totalDebt + equity);
  }

  double getSaleGrowthRate() {
    double currentSale = double.parse(data.incomeStatement["annualReports"][0]["totalRevenue"]);
    double initialSale = double.parse(data.incomeStatement["annualReports"][1]["totalRevenue"]);
    double saleGrothRate = (currentSale - initialSale) / initialSale * 100;
    return saleGrothRate;
  }

  double getEpsGrowthRate() {
    double currentEps = getTrailingEps();
    double initialEps = double.parse(data.ePSStore["annualEarnings"][1]["reportedEPS"]);
    double epsGrothRate = (currentEps - initialEps) / initialEps * 100;
    return epsGrothRate;
  }

  double getEquityGrowthRate() {
    double currentEquity = double.parse(data.balanceSheet["annualReports"][0]["totalAssets"])
                         - double.parse(data.balanceSheet["annualReports"][0]["totalLiabilities"]);
    double initialEquity = double.parse(data.balanceSheet["annualReports"][1]["totalAssets"])
                         - double.parse(data.balanceSheet["annualReports"][1]["totalLiabilities"]);
    double equityGrothRate = (currentEquity - initialEquity) / initialEquity * 100;
    return equityGrothRate;
  }

  double getCashFlow() {
    double currentCashFlow = double.parse(data.cashFlow["annualEarnings"][0]["operatingCashflow"]);
    double initialCashFlow = double.parse(data.cashFlow["annualEarnings"][1]["operatingCashflow"]);
    double cashFlow = (currentCashFlow - initialCashFlow) / initialCashFlow * 100;
    return cashFlow;
  }


  @override
  Widget build(BuildContext context) {
    return Result(earnings: getTrailingEps());
  }
}