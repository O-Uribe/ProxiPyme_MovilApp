import 'package:flutter/material.dart';
import 'package:proxi_pyme/utils/constants.dart';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    configurarCloudinary();

    return Scaffold(
        backgroundColor: Colors.teal.shade50,
        appBar: construirAppBar(),
        body: construirBody(context));
  }

  void configurarCloudinary() {
    CloudinaryContext.cloudinary =
        Cloudinary.fromCloudName(cloudName: "drjqvi7mx");
  }

  AppBar construirAppBar() {
    return AppBar(
      title: const Text(
        "Bienvenido",
        style: TextStyle(fontSize: 22),
      ),
      centerTitle: true,
      backgroundColor: Colors.teal,
      automaticallyImplyLeading: false,
    );
  }

  Widget construirBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          construirTextoBienvenida(),
          const SizedBox(height: 20),
          construirLogo(),
          construirBotonInicio(context),
          const SizedBox(height: 5),
          construirBotonRegistro(context),
        ],
      ),
    );
  }

  Widget construirTextoBienvenida() {
    return Text(
      "Bienvenido a ProxiPyme",
      style: TextStyle(
          color: Colors.teal, fontSize: 40, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget construirLogo() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: CldImageWidget(publicId: "logo"),
    );
  }

  Widget construirBotonInicio(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/Login');
      },
      icon: Icon(loginIcon),
      style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
      label: Text("Iniciar sesión", style: TextStyle(fontSize: 18)),
    );
  }

  Widget construirBotonRegistro(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/Register');
      },
      style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
      child: Text("Registrarse", style: TextStyle(fontSize: 18)),
    );
  }
}
