import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:flutter_perpill_app/noteScreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  void handleNewDate(date) {
    print("handleNewDate ${date}");
  }
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  Widget _currentScreen = NoteScreen();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting("es_ES", null).then((_) => CalendarScreen());
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Calendario'),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new ListView(
            shrinkWrap: false,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Añadir nota'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return NoteScreen(title: "Notas");
                  }));
                },
              ),
              new Calendar(
                isExpandable: true,
//                dayBuilder: (c, day){
//
//                },
              //showTodayAction: true,
              ),
              new Divider(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}