import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

class CheckAccount extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const CheckAccount({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "¿No tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(login ? "Regístrate" : "Inicia sesión",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
