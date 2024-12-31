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
    roicInfo['currentRoicRate'] = listOfRoic[0];
    roicInfo['fiveYearRoicRate'] = (listOfRoic[0] + listOfRoic[1] + listOfRoic[2] + listOfRoic[3] + listOfRoic[4]) / 5;
    roicInfo['tenYearRoicRate'] = (listOfRoic.reduce((value, element) => value + element) / years ).toStringAsFixed(2);
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
    for (int i = 0; i <= count; i++) {
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
    for (int i = 0; i <= count; i++) {
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

  Map<String, dynamic> cashVDebtInfo() {
    Map<String, dynamic> cashVDebtInfo = {};
    int cashAndCashEquivalents;
    int longTermDebt;
    int shortTermDebt;
    if (balanceSheet[0]["cashAndCashEquivalentsAtCarryingValue"] == 'None' 
        || balanceSheet[0]["longTermDebtNoncurrent"] == 'None'
        || balanceSheet[0]["shortTermDebt"] == 'None') {
      cashVDebtInfo['checkCashVDebt'] = 'None';
    } else {
      cashAndCashEquivalents = int.parse(balanceSheet[0]["cashAndCashEquivalentsAtCarryingValue"]);
      longTermDebt = int.parse(balanceSheet[0]["longTermDebtNoncurrent"]);
      shortTermDebt = int.parse(balanceSheet[0]["shortTermDebt"]);
      cashVDebtInfo['checkCashVDebt'] = cashAndCashEquivalents < longTermDebt + shortTermDebt ? false : true;
    }
    return cashVDebtInfo;
  }

  Map<String, dynamic> debtToEquityInfo() {
    Map<String, dynamic> debtToEquityInfo = {};
    double totalLiabilities;
    double shareHodlersEquity;
    if (balanceSheet[0]["totalLiabilities"] == 'None' || balanceSheet[0]["totalShareholderEquity"] == 'None') {
      debtToEquityInfo["checkDebtToEquity"] = 'None';
    } else {
      totalLiabilities = double.parse(balanceSheet[0]["totalLiabilities"]);
      shareHodlersEquity = double.parse(balanceSheet[0]["totalShareholderEquity"]);
      debtToEquityInfo["checkDebtToEquity"] = totalLiabilities / shareHodlersEquity > 0.8 ? false : true;
    }
    return debtToEquityInfo;
  }

  Map<String, dynamic> retainedEarningsInfo() {
    Map<String, dynamic> retainedEarnings = {};
    double currentRetainedEarnings;
    double prevRetinedEarnings;
    if (balanceSheet[0]["retainedEarnings"] == 'None' || balanceSheet[1]["retainedEarnings"] == 'None') {
      retainedEarnings["checkRetainedEarnings"] = 'None';
    } else {
      currentRetainedEarnings = double.parse(balanceSheet[0]["retainedEarnings"]);
      prevRetinedEarnings = double.parse(balanceSheet[1]["retainedEarnings"]);
      retainedEarnings["checkRetainedEarnings"] = currentRetainedEarnings / prevRetinedEarnings < 1 ? false : true;
    }
    return retainedEarnings;
  }

  Map<String, dynamic> treasuryStockInfo(){
    Map<String, dynamic> treasuryStockInfo = {};
    if (balanceSheet[0]["treasuryStock"] == 0) {
      treasuryStockInfo["checkTreasuryStock"] = false;
    } else if(balanceSheet[0]["treasuryStock"] != 0) {
      treasuryStockInfo["checkTreasuryStock"] = true;
    } else {
      treasuryStockInfo["checkTreasuryStock"] = balanceSheet[0]["treasuryStock"];
    }
    return treasuryStockInfo;
  }

  //Analyze Income Statement

  Map<String, dynamic> grossMarginInfo() {
    Map<String, dynamic> grossMarginInfo = {};
    double grossProfit;
    double revenue;
    if (incomeStatement[0]["grossProfit"] == 'None' || incomeStatement[0]["totalRevenue"] == 'None') {
      grossMarginInfo["checkGrossMargin"] = 'None';
    } else {
      grossProfit = double.parse(incomeStatement[0]["grossProfit"]);
      revenue = double.parse(incomeStatement[0]["totalRevenue"]);
      grossMarginInfo["checkGrossMargin"] = grossProfit / revenue < 0.4 ? false : true;
    }
    return grossMarginInfo;
  }

  Map<String, dynamic> sgaMarginInfo() {
    Map<String, dynamic> sgaMarginInfo = {};
    double grossProfit;
    double sga;
    if (incomeStatement[0]["grossProfit"] == 'None' || incomeStatement[0]["sellingGeneralAndAdministrative"] == 'None') {
      sgaMarginInfo["checkSgaMargin"] = 'None';
    } else {
      grossProfit = double.parse(incomeStatement[0]["grossProfit"]);
      sga = double.parse(incomeStatement[0]["sellingGeneralAndAdministrative"]);
      sgaMarginInfo["checkSgaMargin"] = sga / grossProfit > 0.3 ? false : true;
    }
    return sgaMarginInfo;
  }

  Map<String, dynamic> researchAndDevMarginInfo() {
    Map<String, dynamic> marginInfo = {};
    double grossProfit;
    double researchAndDev;
    if (incomeStatement[0]["grossProfit"] == 'None' || incomeStatement[0]["researchAndDevelopment"] == 'None') {
      marginInfo["checkResearchAndDevMargin"] == 'None';
    } else {
      grossProfit = double.parse(incomeStatement[0]["grossProfit"]);
      researchAndDev = double.parse(incomeStatement[0]["researchAndDevelopment"]);
      marginInfo["checkResearchAndDevMargin"] = researchAndDev / grossProfit > 0.6 ? false : true;
    }
    return marginInfo;
  }
   
  Map<String, dynamic> interestMarginInfo() {
    Map<String, dynamic> marginInfo = {};
    double interestExpense;
    double operatingIncome;
    if (incomeStatement[0]["interestExpense"] == 'None' || incomeStatement[0]["operatingIncome"] == 'None') {
      marginInfo["checkMargin"] = 'None';
    } else {
      interestExpense = double.parse(incomeStatement[0]["interestExpense"]);
      operatingIncome = double.parse(incomeStatement[0]["operatingIncome"]);
      marginInfo["checkMargin"] = interestExpense / operatingIncome > 0.15 ? false : true; 
    }
    return marginInfo;
  }

  Map<String, dynamic> incomeTaxMarginInfo() {
    Map<String, dynamic> marginInfo = {};
    if (incomeStatement[0]["incomeTaxExpense"] == 'None' || incomeStatement[0]["incomeBeforeTax"] == 'None') {
      marginInfo["checkMargin"] = 'None';
    } else {
      double incomeTax = double.parse(incomeStatement[0]["incomeTaxExpense"]);
      double preTaxIncome = double.parse(incomeStatement[0]["incomeBeforeTax"]);
      marginInfo["checkMargin"] = incomeTax / preTaxIncome > 0.25 ? false : true;
    }
    return marginInfo;
  }

  Map<String, dynamic> netIncomeMarginInfo() {
    Map<String, dynamic> marginInfo = {};
    double netIncome;
    double revenue;
    if (incomeStatement[0]["netIncome"] == 'None' || incomeStatement[0]["totalRevenue"] == 'None') {
      marginInfo["checkMargin"] = 'None';
    } else {
      netIncome = double.parse(incomeStatement[0]["netIncome"]);
      revenue = double.parse(incomeStatement[0]["totalRevenue"]);
      marginInfo["checkMargin"] = netIncome / revenue < 0.2 ? false : true; 
    }
    return marginInfo;
  }

  Map<String, dynamic> capexMarginInfo() {
    Map<String, dynamic> marginInfo = {};
    double netIncome;
    double capex;
    if (incomeStatement[0]["netIncome"] == 'None' || cashFlow[0]["capitalExpenditures"] == 'None') {
      marginInfo["checkMargin"] = 'None';
    } else {
      netIncome = double.parse(incomeStatement[0]["netIncome"]);
      capex = double.parse(cashFlow[0]["capitalExpenditures"]);
      marginInfo["checkMargin"] = capex / netIncome > 0.25 ? false : true; 
    }
    return marginInfo;
  }

  Map<String, dynamic> getCheckedData() {
    Map<String, dynamic> dataVerification = {};
    dataVerification["getRoicInfo"] = getRoicInfo();
    dataVerification["epsGrowthRate"] = epsGrowthRate();
    dataVerification["saleGrowthRate"] = growthRateInfo(incomeStatement, "totalRevenue", '');
    dataVerification["equityGrowthRate"] = growthRateInfo(balanceSheet, "totalShareholderEquity", '');
    dataVerification["freeCashGrowthRate"] = growthRateInfo(cashFlow, "operatingCashflow", "capitalExpenditures");
    dataVerification["cashVDebt"] = cashVDebtInfo();
    dataVerification["debtToEquity"] = debtToEquityInfo();
    dataVerification["retainedEarnings"] = retainedEarningsInfo();
    dataVerification["treasuryStock"] = treasuryStockInfo();
    dataVerification["grossMargin"] = grossMarginInfo();
    dataVerification["sgaMargin"] = sgaMarginInfo();
    dataVerification["r&DMargin"] = researchAndDevMarginInfo();
    dataVerification["interestMargin"] = interestMarginInfo();
    dataVerification["incomeTaxMargin"] = incomeTaxMarginInfo();
    dataVerification["netIncomeMargin"] = netIncomeMarginInfo();
    dataVerification["capexMargin"] = capexMarginInfo();
    return dataVerification;
  }

  @override
  Widget build(BuildContext context) {

    return Result(
      checkData: getCheckedData(),
    );
  }
}