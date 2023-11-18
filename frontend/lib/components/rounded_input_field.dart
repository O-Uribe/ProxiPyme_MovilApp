import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              border: InputBorder.none,
            )));
  }
}
