import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proxi_pyme/pages/home_page.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse('http://192.168.1.8:5000/api/users/login');
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

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];

      final secureStorage = FlutterSecureStorage();
      await secureStorage.write(key: 'auth_token', value: token);

      if (!context.mounted) return;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return const HomePage();
      }));
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text('Error al iniciar sesión: verifica tus datos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Iniciar sesión"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ingrese sus datos",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              loginUser(context); // Pasa el contexto como argumento
            },
            icon: Icon(loginIcon),
            style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
            label: Text(
              "Iniciar sesión",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
