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

  final List<dynamic> incomeStatement;
  final List<dynamic> balanceSheet;
  final List<dynamic> cashFlow;
  final List<dynamic> epsAnnual;
  final List<dynamic> epsQuart;


  double getTrailingEps() {
    double fourthQuart = double.parse(epsQuart[0]['reportedEPS']);
    double thirdQuart = double.parse(epsQuart[1]['reportedEPS']);
    double secondQuart = double.parse(epsQuart[2]['reportedEPS']);
    double firstQuart = double.parse(epsQuart[3]['reportedEPS']);
    double res = firstQuart + secondQuart + thirdQuart + fourthQuart;

    print('$res + $firstQuart + $secondQuart + $thirdQuart + $fourthQuart');
    return res;
  }

  List<double> getListOfRoic() {
    print('Im in ROIC');
    List<double> listOfRoic = [];
    int years = 10;
    for (int i = 0; i < years; i++) {
      num netIncome = num.parse(incomeStatement[i]["netIncome"]);
      num totalDebt = num.parse(balanceSheet[i]["longTermDebtNoncurrent"])
                       + num.parse(balanceSheet[i]["shortTermDebt"]);
      num equity = num.parse(balanceSheet[i]["totalAssets"])
                    - num.parse(balanceSheet[i]["totalLiabilities"]);
      listOfRoic.add(double.parse((netIncome / (totalDebt + equity) * 100).toStringAsFixed(2)));
    }
    print('stage - 5 $listOfRoic');
    return listOfRoic;
  }
/*
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
*/

  @override
  Widget build(BuildContext context) {
    print('stage - 3');
    return Result(earnings: getTrailingEps(), roic: getListOfRoic(),);
  }
}