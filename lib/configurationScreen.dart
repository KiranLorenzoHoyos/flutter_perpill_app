import 'package:flutter/material.dart';
import 'package:flutter_perpill_app/main.dart';
import 'package:flutter_perpill_app/calendarScreen.dart';

class ConfigurationScreen extends StatefulWidget {
  ConfigurationScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {

  Widget _mainScreen = MyHomePage();
  Widget _calendarScreen = CalendarScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: RaisedButton(
                    child: const Text('Configuracion'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.deepPurple,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CalendarScreen();
                      }));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: RaisedButton(
                    child: const Text('Log Out'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.deepPurple,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MyHomePage(title: "Registro");
                      }));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
