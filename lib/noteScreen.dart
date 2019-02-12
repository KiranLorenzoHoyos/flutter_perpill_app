import 'package:flutter/material.dart';
import 'package:flutter_perpill_app/calendarScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  Widget _calendarScreen = CalendarScreen();

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;


  String _note = '';

  void _onChanged1(bool value) => setState(() => _value1 = value);

  void _onChanged2(bool value) => setState(() => _value2 = value);

  void _onChanged3(bool value) => setState(() => _value3 = value);

  void _onChanged4(bool value) => setState(() => _value4 = value);

  void _onChanged5(bool value) => setState(() => _value5 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Notes',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.pink),
                  ),
                ),
                onChanged: (String user){
                  setState(() {
                    _note = user;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 18.0, right: 18.0),
              child: new SwitchListTile(
                value: _value1,
                onChanged: _onChanged1,
                activeColor: Colors.blue[500],
                title: new Text('Inicio periodo',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: new SwitchListTile(
                value: _value2,
                onChanged: _onChanged2,
                activeColor: Colors.green[500],
                title: new Text('Sigo periodo',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: new SwitchListTile(
                value: _value3,
                onChanged: _onChanged3,
                activeColor: Colors.redAccent,
                title: new Text('Fin periodo',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: new SwitchListTile(
                value: _value4,
                onChanged: _onChanged4,
                activeColor: Colors.yellow[800],
                title: new Text('Pildora',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: new SwitchListTile(
                value: _value5,
                onChanged: _onChanged5,
                activeColor: Colors.cyan[200],
                title: new Text('He tenido relaciones',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: RaisedButton(
                child: const Text('Guardar'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.deepPurple,
                onPressed: addData
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void addData() async {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('Perfiles/-LYWD5NOurqTTi70ybuW/eventos');
      DocumentReference documentReference = reference.document();

      documentReference.setData({"Valor1": _value1, "Valor2": _value2, "Valor3": _value3, "Valor4": _value4, "Valor5": _value5, "Nota": _note}

      );
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CalendarScreen();
      }));
    });
  }
}
