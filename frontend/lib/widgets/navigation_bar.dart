import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function indexActual ;

  const BottomNavigation({super.key, required this.indexActual});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Mostrar contenido en el botón que corresponda
      currentIndex: index,
      onTap: (int i){
        setState(() {
          index = i;
          widget.indexActual(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      
      // Íconos que van en el BottomNavigationBar
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Buscar'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configuración'
        ),
      ],
    );
  }
}