import 'package:flutter/material.dart';

void main() => runApp(MyApp());


List list_image_asset = [
  "4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
];


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: soir());
  }
}

class soir extends StatefulWidget {
  @override
  _soirState createState() => _soirState();
}

class _soirState extends State<soir> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";

  Widget movies(String name, String image, String movie) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: ListTile(
        onTap: (){
          debugPrint("Vous avez cliqué sur $name");
        },
        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          backgroundImage: AssetImage(image),
          radius: 30,
          child: Text(
            image.length == 0? name[0].toUpperCase():"",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        subtitle: Text(
          movie,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.purple),
        ),
      ),
    );
  }

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
      body: ListView(
        children: <Widget>[
          movies("George Clonney",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[3]}",
              "Monkey Monster"),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[0]}",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("George Clonney",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[1]}",
              "Monkey Monster"),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[4]}",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("George Clonney",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[7]}",
              "Monkey Monster"),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[5]}",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[9]}",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),
          movies("Vandamme",
              "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[10]}",
              "Monkey "),
          Divider(height: 10, color: Colors.black,),

        ],
      )
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[],
      //   ),
      // ),
    );
  }
}
