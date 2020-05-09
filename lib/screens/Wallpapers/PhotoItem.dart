import 'package:apod/components/DetailsPhoto.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  final List<Apod> photos;
  final int index;
  const PhotoItem({Key key, this.photos, this.index}) : super(key: key);

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
        _pushDetailsPhotoScreen(context);
      },
    );
  }

  Future _pushDetailsPhotoScreen(BuildContext context) {
    return Navigator.push(
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
  }
}
