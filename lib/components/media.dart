import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        return CachedNetworkImage(
            imageUrl: widget.url,             
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );

      case 'video':
        return Image.asset(
          'images/redirect.jpg',
          fit: BoxFit.cover,
        );

      default:
        return Text('Media type unknown');
    }
  }
}
