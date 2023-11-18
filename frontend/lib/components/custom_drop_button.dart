import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final ValueChanged<String?>? onChanged;

  CustomDropdownButton({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(
            Icons.arrow_drop_down,
            color: const Color.fromARGB(255, 43, 42, 42),
          ),
          iconSize: 30,
          elevation: 16,
          style:
              TextStyle(color: Color.fromARGB(255, 43, 42, 42), fontSize: 18),
          onChanged: onChanged,
          items: ['Cliente', 'Pyme'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
