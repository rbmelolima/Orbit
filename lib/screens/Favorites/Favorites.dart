
import 'package:apod/components/CenteredMessage.dart';
import 'package:apod/components/CircularProgress.dart';
import 'package:apod/database/dao/favorite.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/screens/Favorites/FavoriteGrid.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoritesDao favorite = FavoritesDao();

    return FutureBuilder<List<Apod>>(
      future: favorite.findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return CenteredMessage(
              'Nada foi encontrado!',
              icon: Icons.error_outline,
            );
            break;
          case ConnectionState.waiting:
            return CircularProgress();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            if (snapshot.data.isEmpty) {
              return CenteredMessage(
                'Favorite as melhores fotos!',
                icon: Icons.favorite_border,
              );
            } else {
              return FavoritesGrid(favoritesPhotos: snapshot.data);
            }
            break;
        }

        if (snapshot.hasError) {
          return CenteredMessage(
            'Erro ao carregar os favoritos!',
            icon: Icons.error_outline,
          );
        }

        return CenteredMessage(
          'Nada foi encontrado!',
          icon: Icons.error_outline,
        );
      },
    );
  }
}

