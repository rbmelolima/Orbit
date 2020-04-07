import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

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
        childAspectRatio: 0.8
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if (photos[index].mediaType == 'image') {
          return Image.network(
            photos[index].url,
            fit: BoxFit.cover,
          );
        } else {
          return null;
        }
      },
    );
  }
}