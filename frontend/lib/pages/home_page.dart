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
    return Scaffold(
      bottomNavigationBar: myBottomNavigationBar,
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Menú principal"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: RoutesNavBar(index: index, token: widget.token),
    );
  }
}
