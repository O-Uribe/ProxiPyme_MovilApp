import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final double vertical;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
    this.vertical = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      vertical: vertical,
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
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.0), // Ajusta este valor según tus necesidades
        ),
        maxLines: null, // Permite múltiples líneas de texto
      ),
    );
  }
}
