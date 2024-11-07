import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_investment/share/styled_text.dart';
import 'package:simple_investment/theme.dart';

class SearchField extends StatefulWidget {
  const SearchField({required this.nameController, required this.text, super.key});
  final TextEditingController nameController;
  final String text;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  void clearText() {
    widget.nameController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.nameController,
      cursorColor: AppColors.textColor,
      style: GoogleFonts.publicSans(
        textStyle: Theme.of(context).textTheme.bodyMedium
      ),
      decoration: InputDecoration(
        label: StyledHeading(text: widget.text),
        focusColor: AppColors.focusColor,
        suffixIcon: IconButton(
          onPressed: clearText,
          icon: Icon(Icons.clear, color: AppColors.textColor, size: 15,)
        )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter some text";
        }
        return null;
      },
    );
  }
}

