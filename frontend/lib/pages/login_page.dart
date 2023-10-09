import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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

    // Xalo
    // final url = Uri.parse('http://192.168.1.187:5000/api/users/login');
    // Naxo
    final url = Uri.parse('http://192.168.0.129:5000/api/users/login');
    //Railway
    //final url = Uri.parse(
    //'https://proxipymemovilapp-production.up.railway.app/api/users/login');

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

        if (!context.mounted) return;
        Navigator.pushNamed(context, '/Index');
        
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Error al iniciar sesión: Verifica tus datos'),
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('No puedes dejar campos vacíos'),
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
              obscureText: true,
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
              loginUser(); // Pasa el contexto como argumento
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
