import 'package:flutter/material.dart';
import 'package:proxi_pyme/routes/routes_nav_bar.dart';
import 'package:proxi_pyme/utils/constants.dart';
import 'package:proxi_pyme/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final dynamic token;
  const HomePage({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // Títulos que se muestran en la barra superior de acuerdo al index
  final List<String> titles = [
    "Menú principal",
    "Mapa",
    "Actividad",
    "Perfil de usuario",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        indexActual: (index) {
          setState(() {
            currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 800), curve: Curves.ease);
          });
        },
      ),

      // Títulos y colores de la barra superior
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),

      // Contenido animado de la barra de navegación
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          RoutesNavBar(index: 0, token: widget.token, title: titles[0]),
          RoutesNavBar(index: 1, token: widget.token, title: titles[1]),
          RoutesNavBar(index: 2, token: widget.token, title: titles[2]),
          RoutesNavBar(index: 3, token: widget.token, title: titles[3]),
        ],
      ),
    );
  }
}
