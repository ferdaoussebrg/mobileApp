import 'package:flutter/material.dart';

class UIPage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/meow.webp',
    'assets/image2.jpg',
    'assets/random.gif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI page'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePaths[index],
              width: 200, // Largeur personnalisée
              height: 200, // Hauteur personnalisée
              fit: BoxFit.contain, // Ajustement de l'image dans les dimensions données
            ),
          );
        },
      ),
    );
  }
}