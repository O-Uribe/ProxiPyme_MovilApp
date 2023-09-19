import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/home_page.dart';
import 'package:proxi_pyme/utils/constants.dart';

class LoginPage extends StatelessWidget {
	const LoginPage({super.key});

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
					SizedBox(
							height: 20,
						),  
					ElevatedButton.icon(
							onPressed: () {
								Navigator.of(context).push(
									MaterialPageRoute(builder: (BuildContext context){
										return const HomePage();
									})
								);
							},
							icon: Icon(loginIcon),
							style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
							label: Text(
								"Iniciar sesión",
								style: TextStyle(fontSize: 18),
							)
						)
				],
			),
		);
	}
}
