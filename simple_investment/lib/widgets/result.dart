import 'package:flutter/material.dart';
import 'package:simple_investment/theme.dart';

class Result extends StatefulWidget {
  const Result({
    required this.roic,
    required this.salesGrowthRate,
    required this.epsGrowthRate,
    required this.equityGrowthRate,
    required this.freeCashFlowRate,
    super.key
  });
  final List<double> roic;
  final List<double> salesGrowthRate;
  final List<double> epsGrowthRate;
  final List<double> equityGrowthRate;
  final List<double> freeCashFlowRate;

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
        '${widget.roic}\n${widget.salesGrowthRate}\n${widget.epsGrowthRate}\n${widget.equityGrowthRate}\n${widget.freeCashFlowRate}'),
    );
  }
}