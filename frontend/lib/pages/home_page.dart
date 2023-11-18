import 'package:flutter/material.dart';
import 'package:proxi_pyme/routes/routes_nav_bar.dart';
import 'package:proxi_pyme/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final dynamic token;
  const HomePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BottomNavigation? myBottomNavigationBar;

  @override
  void initState() {
    myBottomNavigationBar = BottomNavigation(indexActual: (i) {
      setState(() {
        index = i;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Menú principal"; // Título predeterminado
    if (index == 1) {
      title = "Mapa";
    } else if (index == 2) {
      title = "Actividad";
    } else if (index == 3) {
      title = "Perfil de usuario";
    }
    return Scaffold(
      bottomNavigationBar: myBottomNavigationBar,
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 26, 101, 158),
      ),
      body: RoutesNavBar(index: index, token: widget.token),
    );
  }
}
