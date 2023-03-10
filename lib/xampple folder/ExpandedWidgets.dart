import 'package:flutter/material.dart';

var directory = "/Users/user/StudioProjects/projet_flutter2/images/";
List list_image_asset = [
  "${directory}4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "${directory}6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "${directory}6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "${directory}9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "${directory}21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "${directory}520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "${directory}950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "${directory}73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "${directory}A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "${directory}CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "${directory}ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "${directory}FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(info),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(list_image_asset[3]),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
            Container(
              child: Text("C'est une application d'apprentissage", style: TextStyle(fontSize: 25, color: Colors.teal, fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Icon(Icons.stars, color: Colors.orange,size: 25,),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Icon(Icons.stars, color: Colors.green,size: 25,),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Icon(Icons.stars, color: Colors.blue,size: 25,),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Icon(Icons.stars, color: Colors.red,size: 25,),
              ),
            ),

                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(2.5),
                width: MediaQuery.of(context).size.width,
                child: Text("Cameroun mon beaux pays, je suis patriote comme tous les autres", style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),),

              ),
            )
          ],
        ),
      ),
    );
  }
}
