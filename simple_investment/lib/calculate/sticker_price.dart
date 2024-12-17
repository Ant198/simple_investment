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

  //Find growth rate

  double getTrailingEps() {
    double fourthQuart = double.parse(epsQuart[0]['reportedEPS']);
    double thirdQuart = double.parse(epsQuart[1]['reportedEPS']);
    double secondQuart = double.parse(epsQuart[2]['reportedEPS']);
    double firstQuart = double.parse(epsQuart[3]['reportedEPS']);
    double res = firstQuart + secondQuart + thirdQuart + fourthQuart;
    return res;
  }

  Map<String, dynamic> getRoicInfo() {
    Map<String, dynamic> roicInfo = {};
    List<double> listOfRoic = [];
    double roic;
    bool checkRoic = true;
    int years = 10;
    for (int i = 0; i < years; i++) {
      double netIncome = double.parse(incomeStatement[i]["netIncome"]);
      double longTermDebt = double.parse(balanceSheet[i]["longTermDebtNoncurrent"] == 'None' ? '0' : balanceSheet[i]["longTermDebtNoncurrent"]);
      double shortTermDebt = double.parse(balanceSheet[i]["shortTermDebt"]);
      double totalDebt = longTermDebt + shortTermDebt;
      double equity = double.parse(balanceSheet[i]["totalShareholderEquity"]);
      roic = double.parse((netIncome / (totalDebt + equity) * 100).toStringAsFixed(2));
      if (roic >= 10) {
        listOfRoic.add(roic);
      } else {
        checkRoic = false;
      }
    }
    roicInfo['currentRoic'] = listOfRoic[0];
    roicInfo['roicRate'] = (listOfRoic.reduce((value, element) => value + element) / years).toStringAsFixed(2);
    roicInfo['checkRoic'] = checkRoic;
    return roicInfo;
  }

  Map<String, dynamic> epsGrowthRate() {
    Map<String, dynamic> growthRateInfo = {};
    List<double> listGrowthRate = [];
    bool checkGrowthRate = true;
    int count = 9;
    double current;
    double initial;
    double growthRate;
    double fiveYearGrowthRate;
    double tenYearGrowthRate;
    for (int i = 1; i <= count; i++) {
        current = double.parse((double.parse(incomeStatement[i]["netIncome"]) 
                / double.parse(balanceSheet[i]["commonStockSharesOutstanding"])).toStringAsFixed(2));
        initial = double.parse((double.parse(incomeStatement[i + 1]["netIncome"]) 
                / double.parse(balanceSheet[i + 1]["commonStockSharesOutstanding"])).toStringAsFixed(2));
      growthRate = double.parse(((current - initial) / initial * 100).toStringAsFixed(2));
      listGrowthRate.add(growthRate);
    }
    growthRate = listGrowthRate[0];
    fiveYearGrowthRate = double.parse(((listGrowthRate[0] + listGrowthRate[1] + listGrowthRate[2] + listGrowthRate[3] + listGrowthRate[4]) / 5).toStringAsFixed(2));
    tenYearGrowthRate = double.parse((listGrowthRate.reduce((a, b) => a + b) / count).toStringAsFixed(2));
    if (growthRate < 10 || fiveYearGrowthRate < 10 || tenYearGrowthRate < 10) {
      checkGrowthRate = false;
    }
    growthRateInfo["currentGrowthRate"] = growthRate;
    growthRateInfo["fiveYearGrowthYear"] = fiveYearGrowthRate;
    growthRateInfo["tenYearGrowthRate"] = tenYearGrowthRate;
    growthRateInfo["checkGrowthRate"] = checkGrowthRate;
    return growthRateInfo;
  }

  Map<String, dynamic> growthRateInfo(List<dynamic> data, String key, String key2) {
    Map<String, dynamic> growthRateInfo = {};
    List<double> listGrowthRate = [];
    bool checkGrowthRate = true;
    int count = 9;
    double current;
    double initial;
    double growthRate;
    double fiveYearGrowthRate;
    double tenYearGrowthRate;
    for (int i = 1; i <= count; i++) {
      if (key2 != '') {
        current = double.parse(data[i][key]) - double.parse(data[i][key2]);
        initial = double.parse(data[i + 1][key]) - double.parse(data[i + 1][key2]);
      } else {
        current = double.parse(data[i][key]);
        initial = double.parse(data[i + 1][key]);
      }
      growthRate = double.parse(((current - initial) / initial * 100).toStringAsFixed(2));
      listGrowthRate.add(growthRate);
    }
    growthRate = listGrowthRate[0];
    fiveYearGrowthRate = double.parse(((listGrowthRate[0] + listGrowthRate[1] + listGrowthRate[2] + listGrowthRate[3] + listGrowthRate[4]) / 5).toStringAsFixed(2));
    tenYearGrowthRate = double.parse((listGrowthRate.reduce((a, b) => a + b) / count).toStringAsFixed(2));
    if (growthRate < 10 || fiveYearGrowthRate < 10 || tenYearGrowthRate < 10) {
      checkGrowthRate = false;
    }
    growthRateInfo["currentGrowthRate"] = growthRate;
    growthRateInfo["fiveYearGrowthYear"] = fiveYearGrowthRate;
    growthRateInfo["tenYearGrowthRate"] = tenYearGrowthRate;
    growthRateInfo["checkGrowthRate"] = checkGrowthRate;
    return growthRateInfo;
  }

// Analyze Balance Sheet

  bool checkCashVDebt() {
    bool cashVDebt = true;
    int cashAndCashEquivalents;
    int longTermDebt;
    int shortTermDebt;
    int count = 9;
    for (int i = 0; i < count; i++) {
      cashAndCashEquivalents = int.parse(balanceSheet[i]["cashAndCashEquivalentsAtCarryingValue"]);
      longTermDebt = int.parse(balanceSheet[i]["longTermDebtNoncurrent"]);
      shortTermDebt = int.parse(balanceSheet[i]["shortTermDebt"]);
      if ( cashAndCashEquivalents > longTermDebt + shortTermDebt) {
        cashVDebt = true;
      } else {
        cashVDebt = false;
        break;
      }
    }
    return cashVDebt;
  }

  bool checkDebtToEquity() {
    bool debtToEquity = true;
    double totalLiabilities;
    double shareHodlersEquity;
    int count = 9;
    for (var i = 0; i < count; i++) {
      totalLiabilities = double.parse(balanceSheet[i]["totalLiabilities"]);
      shareHodlersEquity = double.parse(balanceSheet[i]["totalShareholderEquity"]);
      if (totalLiabilities / shareHodlersEquity < 0.8) {
        debtToEquity = true;
      } else {
        debtToEquity = false;
        break;
      }
    }
    return debtToEquity;
  }

  bool checkRetainedEarnings() {
    bool retainedEarnings = true;
    double currentRetainedEarnings;
    double prevRetinedEarnings;
    int count = 8;
    for (int i = 0; i < count; i++) {
      currentRetainedEarnings = double.parse(balanceSheet[i]["retainedEarnings"]);
      prevRetinedEarnings = double.parse(balanceSheet[i + 1]["retainedEarnings"]);
      if (currentRetainedEarnings / prevRetinedEarnings > 1) {
        retainedEarnings = true;
      } else {
        retainedEarnings = false;
        break;
      }
    }
    return retainedEarnings;
  }

  bool checkTreasureStock(){
    bool treasureStok = true;
    int count = 9;
    for (var i = 0; i < count; i++) {
      if (balanceSheet[i]["treasuryStock"] != 0) {
        treasureStok = true;
      } else {
        treasureStok = false;
        break;
      }
    }
    return treasureStok;
  }

  //Analyze Income Statement

  bool checkGrossMargin() {
    bool grossMargin = true;
    double grossProfit;
    double revenue;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      revenue = double.parse(incomeStatement[i]["totalRevenue"]);
      if (grossProfit / revenue > 0.4) {
        grossMargin = true;
      } else {
        grossMargin = false;
        break;
      }
    }
    return grossMargin;
  }

  bool checkSgaMargin() {
    bool sgaMargin = true;
    double grossProfit;
    double sga;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      sga = double.parse(incomeStatement[i]["sellingGeneralAndAdministrative"]);
      if (sga / grossProfit < 0.3) {
        sgaMargin = true;
      } else {
        sgaMargin = false;
        break;
      }
    }
    return sgaMargin;
  }

  bool checkResearchAndDev() {
    bool researchAndDevMargin = true;
    double grossProfit;
    double researchAndDev;
    int count = 9;
    for (int i = 0; i < count; i++) {
      grossProfit = double.parse(incomeStatement[i]["grossProfit"]);
      researchAndDev = double.parse(incomeStatement[i]["researchAndDevelopment"]);
      if (researchAndDev / grossProfit < 0.6) {
        researchAndDevMargin = true;
      } else {
        researchAndDevMargin = false;
        break;
      }
    }
    return researchAndDevMargin;
  }
   
  bool checkInterestMargin() {
    bool interestMargin = true;
    double interestExpense;
    double operatingIncome;
    int count = 9;
    for (int i = 0; i < count; i++) {
      interestExpense = double.parse(incomeStatement[i]["interestExpense"] == 'None' ? '0' : incomeStatement[i]["interestExpense"]);
      operatingIncome = double.parse(incomeStatement[i]["operatingIncome"] == 'None' ? '0' : incomeStatement[i]["operatingIncome"]);
      if (interestExpense / operatingIncome < 0.15) {
        interestMargin = true;
      } else {
        interestMargin = false;
        break;
      }
    }
    return interestMargin;
  }

  bool checkIncomeTaxMargin() {
    bool incomeTaxMargin = true;
    double incomeTax;
    double preTaxIncome;
    int count = 9;
    for (int i = 0; i < count; i++) {
      incomeTax = double.parse(incomeStatement[i]["incomeTaxExpense"]);
      preTaxIncome = double.parse(incomeStatement[i]["incomeBeforeTax"]);
      if (incomeTax / preTaxIncome < 0.25 && incomeTax / preTaxIncome > 0.15) {
        incomeTaxMargin = true;
      } else {
        incomeTaxMargin = false;
        break;
      }
    }
    return incomeTaxMargin;
  }

  bool checkProfitMargin() {
    bool profitMargin = true;
    double netIncome;
    double revenue;
    int count = 9;
    for (int i = 0; i < count; i++) {
      netIncome = double.parse(incomeStatement[i]["netIncome"]);
      revenue = double.parse(incomeStatement[i]["incomeBeforeTax"]);
      if (netIncome / revenue > 0.2) {
        profitMargin = true;
      } else {
        profitMargin = false;
        break;
      }
    }
    return profitMargin;
  }

  bool checkCapexMargin() {
    bool capexMargin = true;
    double netIncome;
    double capex;
    int count = 9;
    for (int i = 0; i < count; i++) {
      netIncome = double.parse(incomeStatement[i]["netIncome"]);
      capex = double.parse(cashFlow[i]["capitalExpenditures"]);
      if (capex / netIncome < 0.25) {
        capexMargin = true;
      } else {
        capexMargin = false;
        break;
      }
    }
    return capexMargin;
  }

  Map<String, dynamic> getCheckedData() {
    Map<String, dynamic> dataVerification = {};
    dataVerification["getRoicInfo"] = getRoicInfo();
    dataVerification["epsGrowthRate"] = epsGrowthRate();
    dataVerification["saleGrowthRate"] = growthRateInfo(incomeStatement, "totalRevenue", '');
    dataVerification["equityGrowthRate"] = growthRateInfo(balanceSheet, "totalShareholderEquity", '');
    dataVerification["freeCashGrowthRate"] = growthRateInfo(cashFlow, "operatingCashflow", "capitalExpenditures");
    dataVerification["cashVDebt"] = checkCashVDebt();
    dataVerification["debtToEquity"] = checkDebtToEquity();
    dataVerification["retainedEarnings"] = checkRetainedEarnings();
    dataVerification["treasureStok"] = checkTreasureStock();
    dataVerification["grossMargin"] = checkGrossMargin();
    dataVerification["sgaMargin"] = checkSgaMargin();
    dataVerification["researchAndDevMargin"] = checkResearchAndDev();
    dataVerification["interestMargin"] = checkInterestMargin();
    dataVerification["incomeTaxMargin"] = checkIncomeTaxMargin();
    dataVerification["profitMargin"] = checkProfitMargin();
    dataVerification["capexMargin"] = checkCapexMargin();
    return dataVerification;
  }

  @override
  Widget build(BuildContext context) {
    print('stage - 3');
    return Result(
      checkData: getCheckedData(),
    );
  }
}