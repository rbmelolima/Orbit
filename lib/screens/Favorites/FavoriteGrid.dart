import 'package:apod/models/apod.dart';
import 'package:apod/screens/Favorites/FavoriteItem.dart';
import 'package:flutter/material.dart';

class FavoritesGrid extends StatelessWidget {
  final List<Apod> favoritesPhotos;

  const FavoritesGrid({Key key, this.favoritesPhotos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritesPhotos.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FavoriteItem(
                copyright: favoritesPhotos[index].copyright,
                date: favoritesPhotos[index].date,
                explanation: favoritesPhotos[index].explanation,
                hdurl: favoritesPhotos[index].hdurl,
                mediaType: favoritesPhotos[index].mediaType,
                title: favoritesPhotos[index].title,
                url: favoritesPhotos[index].url,
              ),
            )
          ],
        );
      },
    );
  }
}
