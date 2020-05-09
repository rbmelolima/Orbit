import 'package:apod/components/CenteredMessage.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/screens/Wallpapers/PhotoItem.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  final List<Apod> photos;
  const PhotoGrid({Key key, this.photos}) : super(key: key);

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
          return PhotoItem(
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
