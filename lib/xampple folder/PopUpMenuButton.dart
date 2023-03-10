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
  Animal selectAnimal = choix[0];

  void Select(Animal infoo) {
    setState(() {
      selectAnimal = infoo;
    });
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.airport_shuttle,
              color: Colors.black,
            ),
          ),
          PopupMenuButton(
              icon: Icon(Icons.menu),
              elevation: 14,
              initialValue: choix[1],
              onCanceled: () => print("Vous n'avez rien selectionné"),
              onSelected: Select,
              itemBuilder: (BuildContext context) {
                return choix.map((Animal infos) {
                  return PopupMenuItem<Animal>(
                    child: Text(infos.name),
                    value: infos,
                  );
                }).toList();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Affichage(
                    Info: selectAnimal,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Animal {
  String name;
  String image;

  Animal({required this.name, required this.image});
}

List<Animal> choix = <Animal>[
  Animal(name: "Serpent", image: list_image_asset[8]),
  Animal(name: "Chien", image: list_image_asset[0]),
  Animal(name: "LION", image: list_image_asset[2]),
  Animal(name: "Ours", image: list_image_asset[1]),
  Animal(name: "Leopard", image: list_image_asset[3]),
  Animal(name: "Fuits", image: list_image_asset[4]),
  Animal(name: "Les legumes", image: list_image_asset[5]),
  Animal(name: "Serpent", image: list_image_asset[6]),
];

class Affichage extends StatelessWidget {
  late Animal Info;

  Affichage({Key? key, required this.Info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
              Info.name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            Image.asset(
              Info.image.toString(),
              height: 500,
              width: 500,
            )
          ],
        ),
      ),
    );
  }
}
