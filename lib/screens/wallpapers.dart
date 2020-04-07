import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/components/details_photo.dart';
import 'package:apod/http/apod.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Apod>>(
      future: searchWallpaper(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CenteredMessage(
            'Erro!',
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
            return PhotosGrid(
              photos: snapshot.data,
            );
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

class PhotosGrid extends StatelessWidget {
  final List<Apod> photos;

  const PhotosGrid({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if (photos[index].mediaType == 'image' && photos[index].url != null ||
            photos[index].url != '') {
          return InkWell(
            child: Image.network(
              photos[index].url,
              fit: BoxFit.cover,
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
                        copyright: photos[index].copyright,
                        explanation: photos[index].explanation,
                        hdurl: photos[index].hdurl,
                        mediaType: photos[index].mediaType,
                        title: photos[index].title,
                        url: photos[index].url,
                        date: photos[index].date,
                      ),
                    ),
                  );
                }),
              );
            },
          );
        } else
          return null;
      },
    );
  }
}