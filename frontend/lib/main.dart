import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/login_page.dart';
import 'package:proxi_pyme/pages/register_page.dart';
import 'package:proxi_pyme/utils/constants.dart';

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				primarySwatch: Colors.teal,
				useMaterial3: true
			),
			home: const MainPage(),
		);
	}
}

class MainPage extends StatelessWidget {
	const MainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.teal.shade50,
			appBar: AppBar(
				title: const Text("Bienvenido", style: TextStyle(fontSize: 22),),
				centerTitle: true,
				backgroundColor: Colors.teal,
			),
			body: Center(
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
						ElevatedButton.icon(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(
										builder: (BuildContext context){
											return const LoginPage();
										}
									)
								);
							},
							icon: Icon(loginIcon),
							style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
							label: Text(
								"Iniciar sesión",
								style: TextStyle(fontSize: 18),
							)
						),
						SizedBox(
							height: 5,
						),
						ElevatedButton(
							onPressed: () {
								Navigator.push(
									context,
									MaterialPageRoute(
										builder: (BuildContext context){
											return const RegisterPage();
										}
									)
								);
							},
							style: ElevatedButton.styleFrom(
								minimumSize: Size(250, 45)
							),
							child: Text(
								"Registrarse",
								style: TextStyle(
									fontSize: 18
								),
							),
						),
					],
				),
			),
		);
	}
}
