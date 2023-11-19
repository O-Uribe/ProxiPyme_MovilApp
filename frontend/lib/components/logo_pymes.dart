import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class IconoLogo extends StatefulWidget {
  final String? logoUrl;

  const IconoLogo({Key? key, this.logoUrl}) : super(key: key);

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
                width: 50,
                height: 50,
                fit: BoxFit.cover, // Ajusta la imagen dentro del círculo
              ),
            )
          : ClipOval(
              child: Image.asset(
                'assets/images/perfil.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
