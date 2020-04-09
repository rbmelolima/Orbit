import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool statusFavorite;
  final MaterialColor colorIcon;
  final Function onclick;

  const FavoriteButton(
      {Key key, this.statusFavorite, this.colorIcon, @required this.onclick})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite),
      color: widget.colorIcon,
      onPressed: () => widget.onclick(),
    );
  }
}
