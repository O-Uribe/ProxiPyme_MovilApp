import 'package:flutter/material.dart';
import 'package:proxi_pyme/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return const MainPage();
                  })
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(250, 45)),
              child: Text(
                "Volver al inicio",
                style: TextStyle(fontSize: 18),
              )
            )
          ],
        ),
      ),
    );
  }
}