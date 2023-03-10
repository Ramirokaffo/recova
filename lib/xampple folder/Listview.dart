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

  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }
  void change1(bool s){
    setState(() {
      val1 = s;
    });
  }
  void change2(bool t){
    setState(() {
      val2 = t;
    });
  }
  void change3(double f){
    setState(() {
      val3 = f;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Tableau de bord",
                style: TextStyle(color: Colors.indigo, fontSize: 25),)
              ],
            ),

          Container(
            height: 400,
            width: 350,
            color: Colors.lightBlue,
            child: viewer(),
          )],
        ),
      ),
    );
  }
}

Widget viewer(){
  return ListView(
    children: <Widget>[
      TextField(decoration: InputDecoration(
          labelText: "Numero",
          hintText: "Veuillez entrer votre numero de telephone",
          icon: Icon(Icons.phone, size: 25, color: Colors.blue,)
      ),
        keyboardType: TextInputType.number,
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.orangeAccent, size: 30,),
        title: Text("Bamboutos en force",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: Text("Babadjou-Bamedou",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: const Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: const Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: const Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: const Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: const Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: const Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: const Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: const Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
      ListTile(
        leading: Icon(Icons.flight_takeoff, color: Colors.green, size: 30,),
        title: const Text("Afrique de l'ouest",
        style: TextStyle(color: Colors.black, fontSize: 20),),
        subtitle: const Text("TOGO",
          style: TextStyle(color: Colors.white, fontSize: 20),),
        onTap: (){
          debugPrint("Nous sommes au Cameroun");
        },
      ),
    ],
  );
}