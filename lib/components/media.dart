import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaAPI extends StatefulWidget {
  final String mediaType;
  final String url;
  final String hdurl;

  const MediaAPI({this.mediaType, this.url, this.hdurl});

  @override
  _MediaAPIState createState() => _MediaAPIState();
}

class _MediaAPIState extends State<MediaAPI> {
  @override
  Widget build(BuildContext context) {
    switch (widget.mediaType) {
      case 'image':
        return InkWell(
          child: Image.network(widget.url),
          onTap: () {
            launch(widget.hdurl);
          },
        );

      case 'video':
        return InkWell(
          child: Image.asset('images/redirect.jpg'),
          onTap: () {
            launch(widget.url);
          },
        );

      default:
        return Text('Media type unknown');
    }
  }
}