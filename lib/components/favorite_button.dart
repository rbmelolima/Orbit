import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Function onclick;
  final bool favorited;

  const FavoriteButton({Key key, @required this.onclick, this.favorited})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  var color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite),
      color: color,
      onPressed: () {
        widget.onclick();
        setState(() {
          color = Colors.red;
        });
      },
    );
  }
}
