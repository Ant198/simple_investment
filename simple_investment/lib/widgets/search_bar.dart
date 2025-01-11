import 'package:flutter/material.dart';
import 'package:simple_investment/provider/company_data_provider.dart';
import 'package:simple_investment/screen/result.dart';
import 'package:simple_investment/share/styled_text.dart';
import 'package:simple_investment/theme.dart';

class SearchField extends StatefulWidget {
  const SearchField({required this.nameController, required this.text , required this.provider, super.key});
  final TextEditingController nameController;
  final String text;
  final CompanyDataProvider provider;
  
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  void handleSubmit(CompanyDataProvider saveData) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: StyledText(text: 'Processing Data'))
    );
    await saveData.fetchCompanyData(widget.nameController.text);
    if(!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(ticker: widget.nameController.text,)));
  }
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: widget.nameController,
      leading: Icon(Icons.search, color: AppColors.textColor,),
      hintText: widget.text,
      backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      textStyle: MaterialStateProperty.all(TextStyle(
        color: AppColors.textColor,
      )),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      onSubmitted: (value) => handleSubmit(widget.provider),
    );
  }
}