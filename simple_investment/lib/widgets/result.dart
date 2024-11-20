import 'package:flutter/material.dart';
import 'package:simple_investment/theme.dart';

class Result extends StatefulWidget {
  const Result({required this.earnings ,super.key});
  final double earnings;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryColor,
      child: Text('${widget.earnings}'),
    );
  }
}