import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proxi_pyme/components/check_account.dart';
import 'package:proxi_pyme/components/rounded_button.dart';
import 'package:proxi_pyme/components/rounded_input_field.dart';
import 'package:proxi_pyme/components/rounded_password_field.dart';
import 'package:proxi_pyme/pages/login/login_page.dart';
import 'package:proxi_pyme/pages/register/components/background.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "REGISTRO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.20,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: TextEditingController(),
              hintText: "Nombre de usuario",
              onChanged: (value) {},
            ),
            RoundedInputField(
              controller: TextEditingController(),
              hintText: "Correo electrónico",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
                controller: TextEditingController(), onChanged: (value) {}),
            RoundedButton(text: "Registrarse", press: () {}),
            SizedBox(height: size.height * 0.03),
            CheckAccount(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
