import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/components/details_photo.dart';
import 'package:apod/components/favorite_button.dart';
import 'package:apod/database/dao/favorite.dart';
import 'package:apod/models/apod.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            print(snapshot.data);
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
    Apod apod = new Apod(
      copyright: copyright,
      date: date,
      explanation: explanation,
      hdurl: hdurl,
      mediaType: mediaType,
      title: title,
      url: url,
    );

    return Card(
      child: Column(
        children: <Widget>[
          InkWell(
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MaterialApp(
                    title: 'Orbit - Wallpapers',
                    theme: ThemeData.dark(),
                    home: Scaffold(
                      appBar: AppBar(
                        title: Text('Detalhes da foto'),
                      ),
                      body: Details(
                        copyright: copyright,
                        explanation: explanation,
                        hdurl: hdurl,
                        mediaType: mediaType,
                        title: title,
                        url: url,
                        date: date,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 8.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FavoriteButton(
                    apod: apod,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
