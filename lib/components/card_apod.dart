import 'package:apod/components/media.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

import 'favorite_button.dart';

class CardApod extends StatefulWidget {
  final Apod apod;
  const CardApod({Key key, this.apod}) : super(key: key);  

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
            hdurl: widget.apod.hdurl,
            mediaType: widget.apod.mediaType,
            url: widget.apod.url,
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
                          widget.apod.copyright != null
                              ? widget.apod.copyright
                              : 'Autor desconhecido',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.apod.date,
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
              widget.apod.title != null ? widget.apod.title : 'Sem título',
              style: TextStyle(
                fontSize: heightText + 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            widget.apod.explanation != null ? widget.apod.explanation : 'Sem descrição',
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
