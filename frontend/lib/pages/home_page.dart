import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'image_upload_page.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({@required this.token, Key? key}) : super(key: key);

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String email;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['correo'];
  }

  @override
  Widget build(BuildContext context) {
    //var usuario = "Kirby";

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Main Page"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
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
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ImageUploadPage(); // Navega a la página de carga de imágenes
                  }),
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Subir Imagen",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
