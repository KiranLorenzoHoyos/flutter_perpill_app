import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_perpill_app/registerScreen.dart';
import 'package:flutter_perpill_app/dataScreen.dart';
import 'package:flutter_perpill_app/calendarScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PERPILL',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'PERPILL'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _registerScreen = RegisterScreen();
  Widget _calendarScreen = CalendarScreen();
  Widget _dataScreen = DataScreen();
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/walle.jpg'),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Usuario',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  validator: (input){
                    if(input.isEmpty){
                      print('Por favor, introduzca un correo');
                    }
                  },
                  onSaved: (value) => _email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Contraseña',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: new InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                    ),
                  ),
                  validator: (input){
                    if(input.length <6){
                      print('Por favor, introduzca una contraseña de más de 6 caracteres');
                    }
                  },
                  onSaved: (value) => _password = value,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15.0),
                    child: RaisedButton(
                      child: const Text('Entrar'),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.deepPurple,
                      onPressed: signIn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: RaisedButton(
                      child: const Text('Registrar'),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RegisterScreen(title: "Registro");
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

  Future<void> signIn()async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarScreen(user: user)));
      } catch(e){
        print(e.message);
      }
    }
  }
}

