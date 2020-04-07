import 'package:flutter/material.dart';

import 'media.dart';

class Details extends StatefulWidget {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;
  final String mediaType;

  const Details({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.title,
    this.url,
    this.mediaType,
  });

  static const double heightText = 16.0;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    String copyright =
        widget.copyright == null ? 'No copyright' : widget.copyright;
    String title = widget.title == null ? 'No title' : widget.title;
    String explanation =
        widget.explanation == null ? 'No explanation' : widget.explanation;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            MediaAPI(
              hdurl: widget.hdurl,
              mediaType: widget.mediaType,
              url: widget.url,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16, top: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            copyright,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FavoriteButton(),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: Details.heightText + 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              explanation,
              style: TextStyle(
                fontSize: Details.heightText,
                letterSpacing: 0.5,
                height: 1.6,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite),
      color: Colors.red,
      onPressed: () {},
    );
  }
}
