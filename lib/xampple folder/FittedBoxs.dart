import 'package:flutter/material.dart';
import 'package:projet_flutter2/xampple%20folder/StaggeredGridViews.dart';

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

  Widget hairimage(String img) {
    return Container(
      height: 600,
      width: 600,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(65), topRight: Radius.circular(65)),
        child: Image(
          image: AssetImage(img),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget barby(String infos, String subtitle) {
    return Container(
      width: 450,
      // height: 250,
      child: Column(
        children: <Widget>[
          Text(
            infos,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple),
          ),
          Text(
            subtitle,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          )
        ],
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
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: FittedBox(
                  child: Material(
                    color: Colors.white,
                    elevation: 10.0,
                    shadowColor: Colors.grey,
                    borderRadius: BorderRadius.circular(65),
                    child: Column(
                      children: <Widget>[
                        hairimage(list_image_asset[8]),
                        const Padding(padding: EdgeInsets.all(5)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[0]),
                        const Padding(padding: EdgeInsets.all(5)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[1]),
                        const Padding(padding: EdgeInsets.all(4)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[2]),
                        const Padding(padding: EdgeInsets.all(3)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[3]),
                        const Padding(padding: EdgeInsets.all(2)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[4]),
                        const Padding(padding: EdgeInsets.all(1)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        hairimage(list_image_asset[5]),
                        const Padding(padding: EdgeInsets.all(0)),
                        barby(
                            "Bonjour je m'appelle kaffo ramiro",
                            "Camerounais d'origine et je suis Fournir à l’admin le listing des ventes donc les prix de ventes ont été modifiés par rapport aux prix normal ; créer la base des données en tenant compte des modifications et suppressions de ventes"
                                ""),
                        SizedBox(
                          height: 10,
                          child: Container(
                            width: 400,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
        // Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //
        //     ],
        //   ),
        // ),
        );
  }
}
