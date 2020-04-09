import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/components/favorite_button.dart';
import 'package:apod/database/dao/favorite.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoritesDao favorite = FavoritesDao();

    return FutureBuilder<List<Apod>>(
      future: favorite.findAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CenteredMessage(
            'Erro ao carregar os favoritos!',
            icon: Icons.error_outline,
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return CircularProgress();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            break;
        }

        return CenteredMessage(
          'Nada foi encontrado!',
          icon: Icons.error_outline,
        );
      },
    );
  }
}

class FavoritesGrid extends StatelessWidget {
  final List<Apod> favoritesPhotos;

  const FavoritesGrid({Key key, this.favoritesPhotos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            FavoriteItem(
              copyright: favoritesPhotos[index].copyright,
              date: favoritesPhotos[index].date,
              explanation: favoritesPhotos[index].explanation,
              hdurl: favoritesPhotos[index].hdurl,
              mediaType: favoritesPhotos[index].mediaType,
              title: favoritesPhotos[index].title,
              url: favoritesPhotos[index].url,
            )
          ],
        );
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;
  final String mediaType;

  const FavoriteItem(
      {Key key,
      this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.title,
      this.url,
      this.mediaType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(
            url,
            fit: BoxFit.cover,
          ),
          Text(title),
          FavoriteButton(
            colorIcon: Colors.red,
            statusFavorite: true,
            onclick: () {
              
            },
          )
        ],
      ),
    );
  }
}
