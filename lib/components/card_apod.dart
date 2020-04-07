import 'package:apod/components/media.dart';
import 'package:flutter/material.dart';

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
            child: Text(
              widget.copyright != null ? widget.copyright : 'No copyright',
              style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              widget.title != null ? widget.title : 'No title',
              style: TextStyle(
                fontSize: heightText + 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            widget.explanation != null ? widget.explanation : 'No explanation',
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
