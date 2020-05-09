import 'package:apod/models/apod.dart';
import 'package:apod/screens/Apod/CardApod.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: Text('Detalhes da foto'),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              CardApod(
                apod: photos[index],
              )
            ],
          ),
        );
      }),
    );
  }
}
