import 'package:apod/components/media.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

import 'favorite_button.dart';

class CardApod extends StatefulWidget {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;
  final String mediaType;

  const CardApod(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.title,
      this.url,
      this.mediaType});

  @override
  _CardApodState createState() => _CardApodState();
}

class _CardApodState extends State<CardApod> {
  @override
  Widget build(BuildContext context) {
    double heightText = 16.0;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
                          widget.copyright != null
                              ? widget.copyright
                              : 'Autor desconhecido',
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
                  child: FavoriteButton(
                    colorIcon: Colors.grey,
                    statusFavorite: false,
                    onclick: () {
                     
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              widget.title != null ? widget.title : 'Sem título',
              style: TextStyle(
                fontSize: heightText + 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            widget.explanation != null ? widget.explanation : 'Sem descrição',
            style: TextStyle(
              fontSize: heightText,
              letterSpacing: 0.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
