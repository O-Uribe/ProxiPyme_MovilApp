import 'package:http/http.dart' as http;
import 'dart:convert';

// En la URL va la dirección del backend, acompañado de la ruta que se
// encarga de registrar a los usuarios

class RegistrarUser{
	String url = "";

	regUser(Map userData) async{
		try{
			final res = await http.post(Uri.parse("${url}ruta_registro"), body: userData);

			if (res.statusCode == 200){
				var datosUsuario = jsonDecode(res.body.toString());
				print(datosUsuario);
			}
			else{
				print("Fallo al registrar usuario");
			}
		}
		catch(e){
			print(e.toString());
		}
	}
}