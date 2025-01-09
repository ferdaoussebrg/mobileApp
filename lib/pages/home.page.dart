import 'package:flutter/material.dart';
import 'calculs.page.dart';
import 'weather.page.dart';
import 'ui.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    CalculsPage(),
    UIPage(),
    Weather(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDrawerItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.of(context).pop(); // Ferme le drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tp flutter'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculs'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('UI'),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Weather'),
              onTap: () => _onDrawerItemTapped(2),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blueAccent, // Ici on définit la couleur de la barre de navigation
        selectedItemColor: Colors.white, // Change la couleur de l'élément sélectionné en blanc
        unselectedItemColor: Colors.white70, // Change la couleur des éléments non sélectionnés
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'UI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
        ],
      ),
    );
  }
}