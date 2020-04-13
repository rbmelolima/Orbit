import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/components/favorite_button.dart';
import 'package:apod/components/media.dart';
import 'package:apod/http/apod.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

//Picture of the day (APOD)
class APOD extends StatefulWidget {
  @override
  _POTDState createState() => _POTDState();
}

class _POTDState extends State<APOD> {
  Future<Apod> apod;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    apod = cacheApod(dateTime);

    return FutureBuilder<Apod>(
      future: apod,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CenteredMessage(
            'Erro: ' + snapshot.hasData.toString(),
            icon: Icons.error_outline,
          );
        }

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return CircularProgress();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            String copyright = snapshot.data.copyright == null
                ? 'Sem copyright'
                : 'Créditos: ' + snapshot.data.copyright;

            Apod photoDay = Apod(
              url: snapshot.data.url,
              copyright: copyright,
              title: snapshot.data.title,
              explanation: snapshot.data.explanation,
              hdurl: snapshot.data.hdurl,
              date: snapshot.data.date,
              mediaType: snapshot.data.mediaType,
            );

            return ListView(
              children: <Widget>[
                CardApod(
                  apod: photoDay,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime.now(),
                          ).then((date) {
                            setState(() {
                              dateTime = date;
                              print(date);
                            });
                          });
                        },
                        child: Text('Veja mais fotos!'),
                      ),
                    ],
                  ),
                ),
              ],
            );
            break;
        }

        return CenteredMessage(
          'Nada foi encontrado!',
          icon: Icons.error_outline,
        );
      },
    );
  }
}

class CardApod extends StatefulWidget {
  final Apod apod;
  const CardApod({Key key, this.apod}) : super(key: key);

  @override
  _CardApodState createState() => _CardApodState();
}

class _CardApodState extends State<CardApod> {
  @override
  void initState() {
    super.initState();
  }

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
                    apod: widget.apod,
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
            widget.apod.explanation != null
                ? widget.apod.explanation
                : 'Sem descrição',
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
