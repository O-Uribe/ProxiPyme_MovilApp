import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/home_page.dart';
// import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/utils/connection.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.teal.shade50,
			appBar: AppBar(
				title: const Text("Registrarse"),
				centerTitle: true,
				backgroundColor: Colors.teal,
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
							decoration: const InputDecoration(
								border: UnderlineInputBorder(),
								labelText: 'Correo electrónico',
							),
						),
					),
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
						child: TextFormField(
							decoration: const InputDecoration(
								border: UnderlineInputBorder(),
								labelText: 'Contraseña',
							),
						),
					),
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
						child: TextFormField(
							decoration: const InputDecoration(
								border: UnderlineInputBorder(),
								labelText: 'Confirmar contraseña',
							),
						),
					),
					SizedBox(
							height: 20,
						),
					ElevatedButton(
							onPressed: () {

								// Acá en teoría se definen los datos del usuario que serán mandados
								// Como JSON al backend, estos se mandan a la función RegistraUser en
								// el archivo del mismo nombre.
								var datosUsuario = {};
								var registrarUser = RegistrarUser();
								registrarUser.regUser(datosUsuario);

								Navigator.of(context).push(
									MaterialPageRoute(builder: (BuildContext context){
										return const HomePage();
									})
								);
							},
							style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
							child: Text(
								"Registrarse",
								style: TextStyle(fontSize: 18),
							)
						)
				],
			),
		);
	}
}