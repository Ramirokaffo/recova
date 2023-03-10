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
  bool val1 = false;
  bool val2 = false;
  double val3 = 0.0;
  final GlobalKey <ScaffoldState> _sb = GlobalKey <ScaffoldState>();

  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }
void snackbar(){
  _sb.currentState?.showSnackBar(new SnackBar(content: Text("Votre message a ete suppirme")));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sb,
      appBar: AppBar(
        title: Text(info),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: snackbar,
              child: Text("Supprimer le message", style: TextStyle(color: Colors.yellow),),)
          ],
        ),
      ),
    );
  }
}
