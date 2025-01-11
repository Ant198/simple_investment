import 'package:flutter/material.dart';
import 'package:simple_investment/share/styled_text.dart';

class StockInfo extends StatefulWidget {
  const StockInfo({
    required this.checkData,
    required this.intrinsicValue,
    super.key
  });
  final Map<String, dynamic> checkData;
  final double intrinsicValue;

  @override
  State<StockInfo> createState() => _StockInfoState();
}

class _StockInfoState extends State<StockInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              StyledHeading(text: 'Intrinsic Value: ${widget.intrinsicValue}'),
              DataTable(
                columns: const[
                  DataColumn(label: StyledTitle(text: '')),
                  DataColumn(label: StyledTitle(text: 'status')),
                  DataColumn(label: StyledTitle(text: '1-year')),
                  DataColumn(label: StyledTitle(text: '5-years')),
                  DataColumn(label: StyledTitle(text: '10-year')),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(StyledTitle(text: 'Sales Growth Rate')),
                    DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["checkGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["currentGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["fiveYearGrowthYear"]}')),
                    DataCell(StyledText(text: '${widget.checkData["saleGrowthRate"]["tenYearGrowthRate"]}')),
                  ]),
                  DataRow(cells: [
                    const DataCell(StyledTitle(text: 'Equity Growth Rate')),
                    DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["checkGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["currentGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["fiveYearGrowthYear"]}')),
                    DataCell(StyledText(text: '${widget.checkData["equityGrowthRate"]["tenYearGrowthRate"]}')),
                  ]),
                  DataRow(cells: [
                    const DataCell(StyledTitle(text: 'Free Cash Growth Rate')),
                    DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["checkGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["currentGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["fiveYearGrowthYear"]}')),
                    DataCell(StyledText(text: '${widget.checkData["freeCashGrowthRate"]["tenYearGrowthRate"]}')),
                  ]),
                  DataRow(cells: [
                    const DataCell(StyledTitle(text: 'EPS Growth Rate')),
                    DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["checkGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["currentGrowthRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["fiveYearGrowthYear"]}')),
                    DataCell(StyledText(text: '${widget.checkData["epsGrowthRate"]["tenYearGrowthRate"]}')),
                  ]),
                  DataRow(cells: [
                    const DataCell(StyledTitle(text: 'ROIC')),
                    DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["checkRoic"]}')),
                    DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["currentRoicRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["fiveYearRoicRate"]}')),
                    DataCell(StyledText(text: '${widget.checkData["getRoicInfo"]["tenYearRoicRate"]}')),
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
            ],
          ),
        ),
      ),
    );
  }
}