import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

enum TextContainerAlignment {
  top,
  center,
  bottom,
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double vertical;
  final TextContainerAlignment alignment;

  const TextFieldContainer({
    Key? key,
    required this.child,
    this.vertical = 5,
    this.alignment = TextContainerAlignment.top, // Por defecto, alineado arriba
  }) : super(key: key);

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
      child: Align(
        alignment: _getAlignment(),
        child: child,
      ),
    );
  }

  Alignment _getAlignment() {
    switch (alignment) {
      case TextContainerAlignment.top:
        return Alignment.topLeft;
      case TextContainerAlignment.center:
        return Alignment.center;
      case TextContainerAlignment.bottom:
        return Alignment.bottomLeft;
      default:
        return Alignment.topLeft;
    }
  }
}
