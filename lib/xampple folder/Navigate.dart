import 'package:flutter/material.dart';

List list_image = ["4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg"
  , "6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg"
  , "6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg"
  , "9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg"
  , "21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg"
  , "520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg"
  , "950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg"
  , "73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg"
  , "A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg"
  , "CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg"
  , "ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg"
  , "FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"];

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
      appBar: AppBar(
        title: Text(info),
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Restaurant - Menu", style: TextStyle(color: Colors.blue,
                fontSize: 40,
                fontWeight: FontWeight.bold),),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  "/Users/user/StudioProjects/projet_flutter2/images/${list_image[0]}",
                  width: 200, height: 200,),
                FlatButton.icon(
                  onPressed: () {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SecondePage(
                              key: UniqueKey(),
                              val1: "Poulet de chaire",
                              val2: "/Users/user/StudioProjects/projet_flutter2/images/${list_image[6]}"),

                    );
                    Navigator.of(context).push(route);
                  },
                  icon: const Icon(Icons.fastfood, color: Colors.orange, size: 25,),
                  label: const Text("Details"),
                )
              ],
            ),
            const Text("Taro a la sauce jaune", style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  "/Users/user/StudioProjects/projet_flutter2/images/${list_image[1]}",
                  width: 200, height: 200,),
                FlatButton.icon(
                  onPressed: () {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SecondePage(
                              key: UniqueKey(),
                              val1: "Poulet de chaire",
                              val2: "/Users/user/StudioProjects/projet_flutter2/images/${list_image[7]}"),

                    );
                    Navigator.of(context).push(route);
                  },
                  icon: const Icon(Icons.fastfood, color: Colors.orange, size: 25,),
                  label: const Text("Details"),
                )
              ],
            ),
            const Text("Poulet de chaire", style: TextStyle(color: Colors.greenAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  }
}

class SecondePage extends StatelessWidget {
  final String val1 ;
  final String val2 ;

  const SecondePage({required Key key, required this.val1, required this.val2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page des details"),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: const <Widget>[
          Icon(Icons.bluetooth_searching,
          color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Restaurant - Menu", style: TextStyle(color: Colors.blue,
                fontSize: 40,
                fontWeight: FontWeight.bold),),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  "/Users/user/StudioProjects/projet_flutter2/images/${list_image[4]}",
                  width: 200, height: 200,),
                FlatButton.icon(
                  onPressed: null,
                  icon: const Icon(
                    Icons.filter_drama, color: Colors.orange, size: 25,),
                  label: const Text("Details"),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text(val1, style: const TextStyle(color: Colors.orangeAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("$val2", width: 200, height: 200,),

              ],
            ),
            const Text("Cuisson", style: TextStyle(color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            Container(
              height: 200,
              child: const Text(
                "Legume aux frommages. je m'appelle kaffo dzeuyo sonny "
                    "ramiro (sonnyra), je suis actuellement etudiant a YSEM, jai "
                    "deja fait deux annees de formatios en gestion dans cette "
                    "etablissement de renommeesitue entre le rond-point DAMAS et "
                    "les rails d'OBOBGO",
                style: TextStyle(color: Colors.green, fontSize: 30),),
            )
          ],
        ),
      ),
    );
  }
}