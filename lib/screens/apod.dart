import 'package:apod/components/card_apod.dart';
import 'package:apod/components/centered_message.dart';
import 'package:apod/components/circular_progress.dart';
import 'package:apod/http/apod.dart';
import 'package:apod/models/apod.dart';
import 'package:flutter/material.dart';

//Picture of the day (POTD)
class POTD extends StatefulWidget {
  @override
  _POTDState createState() => _POTDState();
}

class _POTDState extends State<POTD> {
  Future<Apod> apod;
  DateTime dateTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    apod = searchImage(dateTime);

    return FutureBuilder<Apod>(
      future: apod,
      builder: (context, snapshot) {
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

            return ListView(
              children: <Widget>[
                CardApod(
                  url: snapshot.data.url,
                  copyright: copyright,
                  title: snapshot.data.title,
                  explanation: snapshot.data.explanation,
                  hdurl: snapshot.data.hdurl,
                  date: dateTime,
                  mediaType: snapshot.data.mediaType,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
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
