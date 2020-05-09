import 'package:apod/components/CenteredMessage.dart';
import 'package:apod/components/CircularProgress.dart';
import 'package:apod/http/apod.dart';
import 'package:apod/models/apod.dart';
import 'package:apod/screens/Apod/CardApod.dart';
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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_today),
        backgroundColor: Colors.white,
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
      ),
      body: FutureBuilder<Apod>(
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
                ],
              );
              break;
          }

          return CenteredMessage(
            'Nada foi encontrado!',
            icon: Icons.error_outline,
          );
        },
      ),
    );
  }
}
