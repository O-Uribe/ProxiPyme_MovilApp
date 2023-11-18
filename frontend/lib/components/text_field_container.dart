import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double vertical;
  const TextFieldContainer({
    super.key,
    required this.child,
    this.vertical = 5,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: vertical),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(29),
        ),
        child: child);
  }
}
