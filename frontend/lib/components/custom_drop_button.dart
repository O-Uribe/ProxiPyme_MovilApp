import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final Map<String, String> items;
  final ValueChanged<String?>? onChanged;
  final double width;
  final IconData? icon;

  CustomDropdownButton({
    required this.value,
    required this.onChanged,
    required this.items,
    this.width = 0.6,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * width,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color.fromARGB(255, 167, 194, 241),
        boxShadow: [
          BoxShadow(
            color: kPrimaryLightColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: kPrimaryColor),
          SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: const Color.fromARGB(255, 43, 42, 42),
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Color.fromARGB(255, 43, 42, 42), fontSize: 18),
                onChanged: onChanged,
                items: items.keys.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
