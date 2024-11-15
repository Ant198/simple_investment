import 'package:flutter/material.dart';
import 'package:simple_investment/share/styled_text.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});
  

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {

  @override
  Widget build(BuildContext context) {
    List<String> name = ['foxf', 'apple', 'meta'];
    return Expanded(
      child: ListView.builder(
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          return StyledText(text: name[index]);
        }
      ),
    );
  }
}