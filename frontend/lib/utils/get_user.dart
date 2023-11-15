import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static Future<List<dynamic>?> fetchUsers() async {
    await dotenv.load(fileName: '.env');
    final url = Uri.parse(dotenv.env['URL_USERS'] ?? '');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        print('Error al obtener los usuarios');
      }
    } catch (error) {
      print('Error de conexión: $error');
    }

    return null;
  }
}
