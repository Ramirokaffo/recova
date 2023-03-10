import 'dart:html';

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
  var info = "Ramiro welcome";
  var value = "Bienvenue chez ramiro";
  var valu1 = "Bienvenue au tuto";
  var note = 0;
  var dat = new DateTime.now().toString();
  var val1 = 0;
  var val2 = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info = "Bienvenue sur le tuto";
  }
  void onclick(){
    setState(() {
      note += 1;
    });
  }
  void onclick2(){
    setState(() {
      note -= 1;
    });
  }
  void show_info(){
    onclick();
    setState(() {
      info = "ramiro $note";
      dat = new DateTime.now().toString();
    });
  }
  void change1(t){
    setState(() {
      val1 = t;
    });
  }
  void change2(n){
    setState(() {
      val2 = n;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          FlatButton(
            onPressed: (){
              debugPrint("-------Bouton Flat ok-------");
            },
            child: Text("Mon bouton Flat", style: TextStyle(fontSize: 20),),
            color: Colors.cyan,
            textColor: Colors.red,
          ),
          IconButton(
            onPressed: ()=>onclick(),
            icon: Icon(Icons.thumb_up, color: Colors.green, size: 20,),
            tooltip: "J'aime",
          ),
          Text("Votre note sur l'application : $note"),
          IconButton(
            onPressed: ()=>onclick2(),
            icon: Icon(Icons.thumb_down, color: Colors.red, size: 20,),
            tooltip: "Je n'aime pas",

          ),
          Text(dat, style: TextStyle(fontSize: 20, backgroundColor: Colors.indigo,), textAlign: TextAlign.center,)

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: show_info,
        focusColor: Colors.green,
        backgroundColor: Colors.red,
        // child: Icon(Icons.timer),
        label: Text("Timer"),
        tooltip: "Il est l'heure",
        icon: Icon(Icons.timer),

      ),
    );
  }
}
