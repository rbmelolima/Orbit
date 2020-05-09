import 'package:apod/Style/Colors.dart';
import 'package:apod/components/FavoriteButton.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/screens/Apod/CardApod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      elevation: 10,
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
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Detalhes da foto'),
                      centerTitle: true,
                    ),
                    body: ListView(
                      children: <Widget>[
                        CardApod(apod: apod,)
                      ],
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
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: softPurple),
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
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.hd,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          launch(apod.url);
                        },
                      ),
                      Container(width: 8),
                      FavoriteButton(
                        apod: apod,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
