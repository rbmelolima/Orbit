import 'package:apod/database/dao/favorite.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Apod apod;
  final MaterialColor color;

  const FavoriteButton({Key key, this.apod, this.color}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  MaterialColor colorFav;

  @override
  void initState() {
    colorFav = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
