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
    return listOfRoic;
  }

  List<double> getSaleGrowthRate() {
    List<double> saleGrothRate = [];
    double currentSale;
    double initialSale;
    int count = 9;
    for (int i = 0; i < count; i++) {
      currentSale = double.parse(incomeStatement[i]["totalRevenue"]);
      initialSale = double.parse(incomeStatement[i + 1]["totalRevenue"]);
      saleGrothRate.add(double.parse(((currentSale - initialSale) / initialSale * 100).toStringAsFixed(2)));
    }
    
    return saleGrothRate;
  }

  List<double> getEpsGrowthRate() {
    List<double> epsGrowthRate = [];
    int count = 9;
    double currentEps;
    double initialEps;
    for (int i = 0; i < count; i++) {
      if(i == 0) {
        currentEps = getTrailingEps();
      } else {
        currentEps = double.parse(epsAnnual[i]["reportedEPS"]);
      }
      initialEps = double.parse(epsAnnual[i + 1]["reportedEPS"]);
      epsGrowthRate.add(double.parse(((currentEps - initialEps) / initialEps * 100).toStringAsFixed(2)));
    }
    return epsGrowthRate;
  }

  List<double> getEquityGrowthRate() {
    List<double> equityGrowthRate = [];
    int count = 9;
    double currentEquity;
    double initialEquity;
    for (int i = 0; i < count; i++) {
      currentEquity = double.parse(balanceSheet[i]["totalAssets"])
                    - double.parse(balanceSheet[i]["totalLiabilities"]);
      initialEquity = double.parse(balanceSheet[i + 1]["totalAssets"])
                    - double.parse(balanceSheet[i + 1]["totalLiabilities"]);
      equityGrowthRate.add(double.parse(((currentEquity - initialEquity) / initialEquity * 100).toStringAsFixed(2)));
    }
    return equityGrowthRate;
  }


  List<double> getFCFRate() {
    List<double> fCFRate = [];
    double currentFreeCashFlow;
    double initialFreeCashFlow;
    int count = 9;
    for (int i = 0; i < count; i++) {
      currentFreeCashFlow = double.parse(cashFlow[i]["operatingCashflow"])
                          - double.parse(cashFlow[i]["capitalExpenditures"]);
      initialFreeCashFlow = double.parse(cashFlow[i + 1]["operatingCashflow"])
                          - double.parse(cashFlow[i + 1]["capitalExpenditures"]);
      fCFRate.add(double.parse(((currentFreeCashFlow - initialFreeCashFlow) / initialFreeCashFlow * 100).toStringAsFixed(2)));
    }
    return fCFRate;
  }


  @override
  Widget build(BuildContext context) {
    print('stage - 3');
    return Result(
      roic: getListOfRoic(),
      salesGrowthRate: getSaleGrowthRate(),
      epsGrowthRate: getEpsGrowthRate(),
      equityGrowthRate: getEquityGrowthRate(),
      freeCashFlowRate: getFCFRate(),
    );
  }
}