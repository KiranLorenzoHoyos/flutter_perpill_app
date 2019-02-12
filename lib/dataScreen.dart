import 'package:flutter/material.dart';
import 'package:flutter_perpill_app/main.dart';
import 'package:flutter_perpill_app/calendarScreen.dart';
import 'package:flutter_perpill_app/registerScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final FirebaseUser user;
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final CollectionReference collectionReference = Firestore.instance.collection("/Perfiles/");
  Widget _mainScreen = MyHomePage();
  Widget _calendarScreen = CalendarScreen();
  Widget _registerScreen = RegisterScreen();
  String _first = '';
  String _height = '';
  String _weight = '';
  String _age = '';
  String _dateText = '';
  String _email = '';
  String _password = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _dateTime = new DateTime.now();
  Future<Null> _selectedDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(context: context, initialDate: _dateTime, firstDate: new DateTime(2016), lastDate: new DateTime(2020));
    if(picked != null && picked != _dateTime){
      print('Fecha seleccionada: ${_dateTime.toString()}');
      setState(() {
        _dateTime = picked;
        _dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Usuario',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (String user){
                    setState(() {
                      _first = user;
                    });
                  },
                ),
              ),
              Text(
                'Edad',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (String age){
                    setState(() {
                      _age = age;
                    });
                  },
                ),
              ),
              Text(
                'Peso',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (String weight){
                    setState(() {
                      _weight = weight;
                    });
                  },
                ),
              ),
              Text(
                'Altura',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  onChanged: (String height){
                    setState(() {
                      _height = height;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(_dateText),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: RaisedButton(
                  child: new Text("Fecha"),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.deepPurple,
                  onPressed: () {
                    _selectedDate(context);
                    },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 55.0, horizontal: 15.0),
                    child: RaisedButton(
                      child: const Text('Volver'),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return MyHomePage(title: "PERPILL");
                        }));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: RaisedButton(
                      child: const Text('Fin'),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.deepPurple,
                      onPressed: _add
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _add (){
    Firestore.instance.runTransaction((Transaction transaction)async{
      CollectionReference reference = Firestore.instance.collection('Perfiles');
      await reference.add({
        "first": _first, "height": _height, "weight": _weight, "date": _dateTime, "age": _age
      });
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return CalendarScreen();
      }));
    });
  }
}
