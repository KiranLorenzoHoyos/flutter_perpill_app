import 'package:flutter/material.dart';
import 'package:flutter_perpill_app/dataScreen.dart';
import 'package:flutter_perpill_app/calendarScreen.dart';
import 'package:flutter_perpill_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Widget _dataScreen = DataScreen();
  Widget _mainScreen = MyHomePage();
  Widget _calendarScreen = CalendarScreen();

  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/walle.jpg'),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Email',
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
            Text(
              'Contraseña',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
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
            Text(
              'Repetir contraseña',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
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
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: RaisedButton(
                    child: const Text('Volver'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.deepPurple,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MyHomePage();
                      }));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  child: RaisedButton(
                    child: const Text('Registrar'),
                    color: Theme.of(context).accentColor,
                    elevation: 4.0,
                    splashColor: Colors.deepPurple,
                    onPressed: signUp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void signUp() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return DataScreen(title: "Registro");
        }));
      } catch(e){
        print(e.message);
      }
    }
  }
}
