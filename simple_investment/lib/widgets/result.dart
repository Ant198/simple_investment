import 'package:flutter/material.dart';
import 'package:simple_investment/theme.dart';

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
    print('stage - 4');
    return Container(
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
  }
}