import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryButton(
              imageAsset: 'assets/images/ñandrejo.png',
              label: 'Categoría 1',
              onTap: () {
                
              },
            ),
            CategoryButton(
              imageAsset: 'assets/images/ñandrejo.png',
              label: 'Categoría 2',
              onTap: () {
                
              },
            ),
            CategoryButton(
              imageAsset: 'assets/images/ñandrejo.png',
              label: 'Categoría 3',
              onTap: () {
                
              },
            ),
            CategoryButton(
              imageAsset: 'assets/images/ñandrejo.png',
              label: 'Categoría 4',
              onTap: () {
                
              },
            ),
            CategoryButton(
              imageAsset: 'assets/images/ñandrejo.png',
              label: 'Categoría 5',
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback onTap;

  CategoryButton({
    required this.imageAsset,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
