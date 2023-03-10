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
  int val1 = 0;
  int val2 = 0;
  bool val4 = false;
  double val3 = 0.0;

  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }

void change1(int s){
    setState(() {
      val1 = s;
    });
}
void change2(int s){
    setState(() {
      val2 = s;
    });
}


Widget boutton_radio(){
    List <Widget> bouton = [];
    for (int i=0; i<4; i++){
      bouton.add(RadioListTile(
        value: i,
        groupValue: val1,
        title: Text("Bonjour"),
        onChanged: (int? newValue) {
            setState(() {
              val1 = newValue!;
            });
          },
      ));
    }
    Column column = Column(
      children: bouton,
    );
    return column;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Bienvenue chez ramiro"),
            boutton_radio()
          ],
        ),
      ),
    );
  }
}
