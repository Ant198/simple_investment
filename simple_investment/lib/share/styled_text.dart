import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.publicSans(
        textStyle: Theme.of(context).textTheme.bodyMedium
      ),
    );
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.publicSans(
        textStyle: Theme.of(context).textTheme.titleMedium
      ),
    );
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading({super.key, required this.text});
  final String text;
  String getText() => text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.publicSans(
        textStyle: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}