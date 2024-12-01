import 'package:flutter/material.dart';
import 'package:simple_investment/theme.dart';

class Result extends StatefulWidget {
  const Result({required this.earnings, required this.roic, super.key});
  final double earnings;
  final List<num> roic;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    print('stage - 4');
    return Container(
      color: AppColors.secondaryColor,
      child: Text('${widget.roic}'),
    );
  }
}