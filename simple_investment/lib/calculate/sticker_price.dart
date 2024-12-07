import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  //Find growth rate

  double getTrailingEps() {
    double fourthQuart = double.parse(epsQuart[0]['reportedEPS']);
    double thirdQuart = double.parse(epsQuart[1]['reportedEPS']);
    double secondQuart = double.parse(epsQuart[2]['reportedEPS']);
    double firstQuart = double.parse(epsQuart[3]['reportedEPS']);
    double res = firstQuart + secondQuart + thirdQuart + fourthQuart;
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

// Analyze Balance Sheet

  List<bool> checkCashVDebt() {
    List<bool> cashVDebt = [];
    int cashAndCashEquivalents;
    int longTermDebt;
    int shortTermDebt;
    int count = 9;
    for (int i = 0; i < count; i++) {
      cashAndCashEquivalents = int.parse(balanceSheet[i]["cashAndCashEquivalentsAtCarryingValue"]);
      longTermDebt = int.parse(balanceSheet[i]["longTermDebtNoncurrent"]);
      shortTermDebt = int.parse(balanceSheet[i]["shortTermDebt"]);
      if ( cashAndCashEquivalents > longTermDebt + shortTermDebt) {
        cashVDebt.add(true);
      } else {
        cashVDebt.add(false);
      }
    }
    return cashVDebt;
  }

  List<bool> checkDebtToEquity() {
    List<bool> debtToEquity = [];
    double totalLiabilities;
    double shareHodlersEquity;
    int count = 9;
    for (var i = 0; i < count; i++) {
      totalLiabilities = double.parse(balanceSheet[i]["totalLiabilities"]);
      shareHodlersEquity = double.parse(balanceSheet[i]["totalShareholderEquity"]) + double.parse(balanceSheet[i]["treasuryStock"]);
      if (totalLiabilities / shareHodlersEquity < 0.8) {
        debtToEquity.add(true);
      } else {
        debtToEquity.add(false);
      }
    }
    return debtToEquity;
  }

  List<bool> checkRetainedEarnings() {
    List<bool> retainedEarnings = [];
    double currentRetainedEarnings;
    double prevRetinedEarnings;
    int count = 8;
    for (int i = 0; i < count; i++) {
      currentRetainedEarnings = double.parse(balanceSheet[i]["retainedEarnings"]);
      prevRetinedEarnings = double.parse(balanceSheet[i + 1]["retainedEarnings"]);
      if (currentRetainedEarnings / prevRetinedEarnings > 1) {
        retainedEarnings.add(true);
      } else {
        retainedEarnings.add(false);
      }
    }
    return retainedEarnings;
  }

  List<bool> checkTreasureStock(){
    List<bool> treasureStok = [];
    int count = 9;
    for (var i = 0; i < count; i++) {
      if (balanceSheet[i]["treasuryStock"] != 0) {
        treasureStok.add(true);
      } else {
        treasureStok.add(false);
      }
    }
    return treasureStok;
  }

  //Analyze Income Statement

  List<bool> getGrossMargin() {
    List<bool> grossMargin = [];
    double grossProfit;
    double revenue;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      revenue = double.parse(incomeStatement[i]["totalRevenue"]);
      if (grossProfit / revenue > 0.4) {
        grossMargin.add(true);
      } else {
        grossMargin.add(false);
      }
    }
    return grossMargin;
  }

  List<bool> getSgaMargin() {
    List<bool> sgaMargin = [];
    double grossProfit;
    double sga;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      sga = double.parse(incomeStatement[i]["sellingGeneralAndAdministrative"]);
      if (sga / grossProfit < 0.3) {
        sgaMargin.add(true);
      } else {
        sgaMargin.add(false);
      }
    }
    return sgaMargin;
  }

  List<bool> getResearchAndDev() {
    List<bool> researchAndDevMargin = [];
    double grossProfit;
    double researchAndDev;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      researchAndDev = double.parse(incomeStatement[i]["researchAndDevelopment"]);
      if (researchAndDev / grossProfit < 0.6) {
        researchAndDevMargin.add(true);
      } else {
        researchAndDevMargin.add(false);
      }
    }
    return researchAndDevMargin;
  }
   
  List<bool> getInterestMargin() {
    List<bool> interestMargin = [];
    double interestExpense;
    double operatingIncome;
    int count = 9;
    for (int i = 0; i < count; i++) {
      interestExpense = double.parse(incomeStatement[i]["interstExpanse"]);
      operatingIncome = double.parse(incomeStatement[i]["operatingIncome"]);
      if (interestExpense / operatingIncome < 0.15) {
        interestMargin.add(true);
      } else {
        interestMargin.add(false);
      }
    }
    return interestMargin;
  }

  List<bool> getIncomeTaxMargin() {
    List<bool> incomeTaxMargin = [];
    double incomeTax;
    double preTaxIncome;
    int count = 9;
    for (int i = 0; i < count; i++) {
      incomeTax = double.parse(incomeStatement[i]["incomeTaxExpense"]);
      preTaxIncome = double.parse(incomeStatement[i]["incomeBeforeTax"]);
      if (incomeTax / preTaxIncome < 0.25 && incomeTax / preTaxIncome > 0.15) {
        incomeTaxMargin.add(true);
      } else {
        incomeTaxMargin.add(false);
      }
    }
    return incomeTaxMargin;
  }

  List<bool> checkProfitMargin() {
    List<bool> profitMargin = [];
    double netIncome;
    double revenue;
    int count = 9;
    for (int i = 0; i < count; i++) {
      netIncome = double.parse(incomeStatement[i]["netIncome"]);
      revenue = double.parse(incomeStatement[i]["incomeBeforeTax"]);
      if (netIncome / revenue > 0.2) {
        profitMargin.add(true);
      } else {
        profitMargin.add(false);
      }
    }
    return profitMargin;
  }

  List<bool> chackCapexMargin() {
    List<bool> capexMargin = [];
    double netIncome;
    double capex;
    int count = 9;
    for (int i = 0; i < count; i++) {
      netIncome = double.parse(incomeStatement[i]["netIncome"]);
      capex = double.parse(cashFlow[i]["capitalExpenditures"]);
      if (capex / netIncome < 0.25) {
        capexMargin.add(true);
      } else {
        capexMargin.add(false);
      }
    }
    return capexMargin;
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