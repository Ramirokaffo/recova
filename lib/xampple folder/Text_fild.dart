import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: soir()
    );
  }
}
class soir extends StatefulWidget {
  @override
  _soirState createState() => _soirState();
}

class _soirState extends State<soir> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  int max = 10;
  String value = "";
  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }

  void submit (a){
    setState(() {
      value = "message envoyé: $a";
    });
  }
  void affiche (b){
    setState(() {
      value = "Bienvenue: $b";
      if (b.length == 20){
        max = 0;
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(value, style: TextStyle(fontSize: 20, color: Colors.blue, ),textAlign: TextAlign.center,),
            TextField(decoration: InputDecoration(
              labelText: "Nom",
              hintText: "Veuillez entrer votre nom",
              icon: Icon(Icons.person, size: 25, color: Colors.blue,)
            ),
              keyboardType: TextInputType.text,
              autocorrect: true,
              autofocus: true,
              onChanged: affiche,
              onSubmitted: submit,
              maxLength: max,
            ),
            TextField(decoration: InputDecoration(
              labelText: "Numero",
              hintText: "Veuillez entrer votre numero de telephone",
              icon: Icon(Icons.phone, size: 25, color: Colors.blue,)
            ),
              keyboardType: TextInputType.number,
            ),
            TextField(decoration: InputDecoration(
              labelText: "Password",
              hintText: "Veuillez entrer votre mot de passe",
              icon: Icon(Icons.lock, size: 25, color: Colors.red,)
            ),
              keyboardType: TextInputType.text,
              obscureText: true,
            )
          ],
        ),
      ),
    );
  }
}
