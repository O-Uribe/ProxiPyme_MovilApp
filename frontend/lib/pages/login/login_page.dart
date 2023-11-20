import 'package:flutter/material.dart';
import 'package:proxi_pyme/components/rounded_button.dart';
import 'package:proxi_pyme/pages/login/components/background.dart';
import 'package:proxi_pyme/components/check_account.dart';
import 'package:proxi_pyme/components/rounded_input_field.dart';
import 'package:proxi_pyme/components/rounded_password_field.dart';
import 'package:proxi_pyme/pages/register/register_page.dart';
import 'package:proxi_pyme/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<SharedPreferences> prefsFuture;

  @override
  void initState() {
    super.initState();
    prefsFuture = SharedPreferences.getInstance();
  }

  void loginUser() async {
    SharedPreferences prefs = await prefsFuture;

    await dotenv.load(fileName: '.env');

    final url = Uri.parse(dotenv.env['URL_LOGIN'] ?? '');

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'correo': emailController.text,
          'contraseña': passwordController.text,
        }),
      );

      var jsonResponse = json.decode(response.body);
      if (jsonResponse['status']) {
        final token = json.decode(response.body)['token'];

        final secureStorage = FlutterSecureStorage();
        await secureStorage.write(key: 'auth_token', value: token);

        prefs.setString('token', token);

        if (!context.mounted) {
          return;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(token: token),
            ),
          );
        }
      } else {
        if (!context.mounted) {
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(
                  'Error al validar el correo electrónico o la contraseña'),
            ),
          );
        }
      }
    } else {
      if (!context.mounted) {
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('No puedes dejar campos vacíos'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "INICIO DE SESIÓN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/icons/register.gif",
                height: size.height * 0.30,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: emailController,
                hintText: "Correo electrónico",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                  controller: passwordController, onChanged: (value) {}),
              RoundedButton(
                  text: "Iniciar sesión",
                  press: () {
                    loginUser();
                  }),
              SizedBox(height: size.height * 0.03),
              CheckAccount(press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
