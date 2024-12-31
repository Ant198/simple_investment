import 'package:flutter/material.dart';
import 'package:simple_investment/share/styled_text.dart';

class Result extends StatefulWidget {
  const Result({
    required this.checkData,
    super.key
  });
  final Map<String, dynamic> checkData;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: DataTable(
          columns: const[
            DataColumn(label: StyledTitle(text: '')),
            DataColumn(label: StyledTitle(text: '1-year')),
            DataColumn(label: StyledTitle(text: '5-years')),
            DataColumn(label: StyledTitle(text: '10-year')),
            DataColumn(label: StyledTitle(text: 'status')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Sales Growth Rate')),
              DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["currentGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["fiveYearGrowthYear"]}')),
              DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["tenYearGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["checkGrowthRate"]}')),      
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Equity Growth Rate')),
              DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["currentGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["fiveYearGrowthYear"]}')),
              DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["tenYearGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["checkGrowthRate"]}')),      
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Free Cash Growth Rate')),
              DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["currentGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["fiveYearGrowthYear"]}')),
              DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["tenYearGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["checkGrowthRate"]}')),      
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'EPS Growth Rate')),
              DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["currentGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["fiveYearGrowthYear"]}')),
              DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["tenYearGrowthRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["checkGrowthRate"]}')),      
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'ROIC')),
              DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["currentRoicRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["fiveYearRoicRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["tenYearRoicRate"]}')),
              DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["checkRoic"]}')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Cash & Debt')),
              DataCell(StyledText(text: '${widget.checkData["cashVDebt"]["checkCashVDebt"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Debt to Equity')),
              DataCell(StyledText(text: '${widget.checkData["debtToEquity"]["checkDebtToEquity"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Retained Earnings')),
              DataCell(StyledText(text: '${widget.checkData["retainedEarnings"]["checkRetainedEarnings"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Treasury Stock')),
              DataCell(StyledText(text: '${widget.checkData["treasuryStock"]["checkTreasuryStock"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Gross Margin')),
              DataCell(StyledText(text: '${widget.checkData["grossMargin"]["checkGrossMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'SG&A Margin')),
              DataCell(StyledText(text: '${widget.checkData["sgaMargin"]["checkSgaMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'R&D Margin')),
              DataCell(StyledText(text: '${widget.checkData["r&DMargin"]["checkResearchAndDevMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Interest Margin')),
              DataCell(StyledText(text: '${widget.checkData["interestMargin"]["checkMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Tax Margin')),
              DataCell(StyledText(text: '${widget.checkData["incomeTaxMargin"]["checkMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Net Income Margin')),
              DataCell(StyledText(text: '${widget.checkData["netIncomeMargin"]["checkMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
            DataRow(cells: [
              const DataCell(StyledTitle(text: 'Capex Margin')),
              DataCell(StyledText(text: '${widget.checkData["capexMargin"]["checkMargin"]}')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
              const DataCell(StyledText(text: '')),
            ]),
          ],
        ),
      ),
    );
  /*
    Container(
      color: AppColors.secondaryColor,
      child: Text(
        '''ROIC - ${widget.checkData["getRoicInfo"]["currentRoic"]}   ${widget.checkData["getRoicInfo"]["roicRate"]}   ${widget.checkData["getRoicInfo"]["checkRoic"]}'''
        '''\n Sales Growth Rates - ${widget.checkData["saleGrowthRate"]}'''
        '''\n EPS Growth Rate - ${widget.checkData["epsGrowthRate"]}'''
        '''\n Equity Growth Rate - ${widget.checkData['equityGrowthRate']}'''
        '''\n Free Cash Flow Growth Rate - ${widget.checkData["freeCashGrowthRate"]}'''
        '''\n Cash v Debt - ${widget.checkData["cashVDebt"]}'''
        '''\n Debt to Equity - ${widget.checkData["debtToEquity"]}'''
        '''\n Retained Earning - ${widget.checkData["retainedEarnings"]}'''
        '''\n Treasure Stock - ${widget.checkData["retainedEarnings"]}'''
        '''\n Gross Margin - ${widget.checkData["grossMargin"]}'''
        '''\n SG&A Margin - ${widget.checkData["sgaMargin"]}'''
        '''\n R&D Margin - ${widget.checkData["researchAndDevMargin"]}'''
        '''\n Interest Margin - ${widget.checkData["interestMargin"]}'''
        '''\n Income Tax Margin - ${widget.checkData["incomeTaxMargin"]}'''
        '''\n Profit Margin - ${widget.checkData["profitMargin"]}'''
        '''\n Capex Margin - ${widget.checkData["capexMargin"]}'''
      ),
    );
  */
  }
}