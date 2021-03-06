import 'package:apod/components/CenteredMessage.dart';
import 'package:apod/components/CircularProgress.dart';
import 'package:apod/http/wallpaper.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/screens/Wallpapers/PhotoGrid.dart';
import 'package:flutter/material.dart';

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Apod>>(
      future: searchWallpaper(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            child: CenteredMessage(
              'Houve um erro inesperado, tente novamente em um outro momento',
              icon: Icons.error_outline,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
            return Padding(
                padding: EdgeInsets.all(12.0),
                child: PhotoGrid(
                  photos: snapshot.data,
                ));
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
