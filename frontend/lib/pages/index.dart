import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

class IndexPage extends StatefulWidget {
  final dynamic token;
  const IndexPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late String email;
  late String userId;
  String? userName; // Variable para almacenar el nombre de usuario

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['correo'];
    userId = jwtDecodedToken['userId'];

    fetchUserName(userId);
  }

  // Función para realizar la solicitud a la API para obtener el nombre de usuario
  Future<void> fetchUserName(String userId) async {
    final url = Uri.parse('http://192.168.1.187:5000/api/users/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        for (var usuario in jsonData) {
          if (usuario['_id'] == userId) {
            setState(() {
              userName = usuario['nombreUsuario'];
            });
          }
        }
      } else {
        print('Error al obtener el nombre de usuario');
      }
    } catch (error) {
      print('Error de conexión: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido $email",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (userName != null)
              Text(
                "Nombre de Usuario: $userName",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
