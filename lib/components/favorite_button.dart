import 'package:apod/database/dao/favorite.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Apod apod;

  const FavoriteButton({Key key, this.apod}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  MaterialColor colorFav;
  FavoritesDao favoritesDao = new FavoritesDao();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MaterialColor>(
      initialData: Colors.grey,
      future: favoritesDao.getColorButton(widget.apod),
      builder: (context, snapshot) {
        colorFav = snapshot.data;
        
        return IconButton(
          icon: Icon(Icons.favorite),
          color: colorFav,
          onPressed: () {
            FavoritesDao photo = FavoritesDao();
            photo.favorite(widget.apod);
            setState(() {
              colorFav = colorFav == Colors.grey ? Colors.red : Colors.grey;
            });
          },
        );
      },
    );
  }
}

/* 
  @override
  void initState() {
    colorFav = widget.color != null ? widget.color : '';
    super.initState();
  }

IconButton(
icon: Icon(Icons.favorite),
color: colorFav,
onPressed: () {
  FavoritesDao photo = FavoritesDao();
  photo.favorite(widget.apod)  setState(() {
    colorFav = colorFav == Colors.grey ? Colors.red : Colors.grey;
  });
}, */
