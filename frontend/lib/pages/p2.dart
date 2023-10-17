import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Para alinear los cuadros en el centro del espacio disponible
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                    context,
                    '/UploadImage',
                  );
            },
            child: Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/mapa.png'), // Reemplaza 'imagen1.png' con la ruta de tu imagen
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4)
              ),
              
              child: Text('Mapa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                )
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
               Navigator.pushNamed(
                    context,
                    '/UploadImage',
                  );
            },
            child: Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ñandrejo.png'), // Reemplaza 'imagen3.png' con la ruta de tu imagen
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Text('Ñandrejo',
              textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
