import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

// Uso de Cloudinary desde frontend
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  

  @override
  Widget build(BuildContext context) {
    // Eventualmente cambiar a imagen en local
    CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: "drjqvi7mx");
    
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text(
          "Bienvenido",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Botón volver atrás
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido a ProxiPyme",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CldImageWidget(publicId: "logo"),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/Login',
                  );
                },
                icon: Icon(loginIcon),
                style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
                label: Text(
                  "Iniciar sesión",
                  style: TextStyle(fontSize: 18),
                )),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/Register',
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Registrarse",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
