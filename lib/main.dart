import 'package:apod/screens/apod.dart';
import 'package:apod/screens/favorites.dart';
import 'package:apod/screens/wallpapers.dart';
import 'package:flutter/material.dart';

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
  final List<Widget> _children = [Wallpaper(), Favorites(), APOD()];

  @override
  Widget build(BuildContext context) {   

    return MaterialApp(
      title: 'Orbit - Wallpapers',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Orbit - Universe wallpapers'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              title: Text('Papéis de parede'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favoritos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Foto do dia'),
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
