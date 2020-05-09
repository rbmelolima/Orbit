import 'package:flutter/material.dart';
import 'screens/Apod/Apod.dart';
import 'screens/Favorites/Favorites.dart';
import 'screens/Wallpapers/Wallpapers.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    APOD(),
    Favorites(),
    Wallpaper(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orbit - Wallpapers',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Orbit - Universe Wallpapers'),
          centerTitle: true,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Foto do dia'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favoritos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              title: Text('Papéis de parede'),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
