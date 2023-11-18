import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/welcome/components/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proxi_pyme/components/rounded_button.dart';
import 'package:proxi_pyme/utils/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Bienvenido a ProxyPyme",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.05),
        SvgPicture.asset(
          "assets/icons/chat.svg",
          height: size.height * 0.45,
        ),
        SizedBox(height: size.height * 0.05),
        RoundedButton(
          text: "Iniciar sesión",
          color: kPrimaryColor,
          press: () {
            Navigator.pushNamed(context, '/Login');
          },
        ),
        RoundedButton(
          text: "Registrarse",
          color: kPrimaryLightColor,
          textColor: Colors.black,
          press: () {
            Navigator.pushNamed(context, '/Register');
          },
        ),
      ],
    ));
  }
}
