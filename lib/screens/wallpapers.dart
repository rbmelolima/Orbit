import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/components/details_photo.dart';
import 'package:apod/http/wallpaper.dart';
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
            return Padding(
                padding: EdgeInsets.all(12.0),
                child: PhotosGrid(
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
        childAspectRatio: 0.6,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if (photos[index].mediaType == 'image') {
          return ImageColumn(
            photos: photos,
            index: index,
          );
        } else
          return CenteredMessage(
            'Imagem não encontrada',
            icon: Icons.broken_image,
            fontSize: 16.0,
            iconSize: 32.0,
          );
      },
    );
  }
}

class ImageColumn extends StatelessWidget {
  final List<Apod> photos;
  final int index;
  const ImageColumn({Key key, this.photos, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image.network(
          photos[index].url,
          fit: BoxFit.cover,
        ),
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
  }
}
