import 'package:flutter/material.dart';
import 'package:proxi_pyme/pages/login_page.dart';
import 'package:proxi_pyme/pages/register_page.dart';

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
        title: const Text("Bienvenido"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 55,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const LoginPage();
                  })
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Iniciar sesión",
                style: TextStyle(fontSize: 18),
              )
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const RegisterPage();
                  })
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Registrarse",
                style: TextStyle(fontSize: 18),
              )
            ),
          ],
        ),
      ),
    );
  }
}
