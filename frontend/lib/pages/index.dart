import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import '../widgets/search.dart';

class IndexPage extends StatefulWidget {
  final dynamic token;
  const IndexPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late String email;
  late String userId;
  String? userName;

  String searchQuery = "";
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['correo'];
    userId = jwtDecodedToken['userId'];

    fetchUserName(userId);
  }

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

  void searchUsers(String query) {
    setState(() {
      searchQuery = query;
      // Lógica de búsqueda de usuarios aquí, puedes usar `fetchUserName` con filtros.
      // Actualiza `searchResults` con los resultados de la búsqueda.
      // Ejemplo: searchResults = ['Usuario1', 'Usuario2', ...];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Hola $userName",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            UserSearchBar(onSearch: searchUsers),
            if (searchResults.isNotEmpty)
              Column(
                children: searchResults.map((result) => Text(result)).toList(),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, 
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/UploadImage',
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/mapa.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text('Mapa',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/UploadImage',
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/ñandrejo.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text('Ñandrejo',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
