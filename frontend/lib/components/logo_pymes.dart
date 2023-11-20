import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class IconoLogo extends StatefulWidget {
  final String? logoUrl;
  final double width;
  final double height;

  const IconoLogo({
    Key? key,
    this.logoUrl,
    this.width = 50.0,
    this.height = 50.0,
  }) : super(key: key);

  @override
  State<IconoLogo> createState() => _IconoLogoState();
}

class _IconoLogoState extends State<IconoLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kPrimaryLightColor),
      ),
      child: widget.logoUrl != null
          ? ClipOval(
              child: Image.network(
                widget.logoUrl!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
              ),
            )
          : ClipOval(
              child: Image.asset(
                'assets/images/perfil.png',
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
