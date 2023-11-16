import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import '../widgets/search.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IndexUserPage extends StatefulWidget {
  final dynamic token;
  const IndexUserPage({@required this.token, Key? key}) : super(key: key);

  @override
  State<IndexUserPage> createState() => _IndexUserPageState();
}

class _IndexUserPageState extends State<IndexUserPage> {
  late String userId;

  Map<String, dynamic>? userData;
  String searchQuery = "";
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['userId'];

    fetchUser(userId);
  }

  Future<void> fetchUser(String userId) async {
    await dotenv.load(fileName: '.env');
    final url = Uri.parse(dotenv.env['URL_USERS'] ?? '');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        for (var usuario in jsonData) {
          if (usuario['_id'] == userId) {
            setState(() {
              userData = usuario;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text(
                  "Hola ${userData?['nombreUsuario']}",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 20),
              ],
            ),
            UserSearchBar(onSearch: searchUsers),
            if (searchResults.isNotEmpty)
              Column(
                children: searchResults.map((result) => Text(result)).toList(),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Function onTap;

  CustomImageButton({
    required this.imageAsset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}