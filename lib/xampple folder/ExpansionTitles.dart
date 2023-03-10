import 'package:flutter/material.dart';
import 'package:projet_flutter2/xampple%20folder/PositionnedWidgets.dart';

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

  Widget resto(String image, Color color, String title, String resume) {

    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 340,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover)),
                  ),
                )
              ],
            )
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.stars,
                    color: color,
                    size: 25,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.stars,
                    color: color,
                    size: 25,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.stars,
                    color: color,
                    size: 25,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.stars,
                    color: color,
                    size: 25,
                  ),
                ),
                Container(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.star_border,
                    color: color,
                    size: 25,
                  ),
                ),
                Container(
                  width: 200,
                  child: ExpansionTile(
                    title: Text(
                      title,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Text(resume),
                      Image.asset(image)
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            resto(list_image_asset[9],
                Colors.orange,
                "Ramiro kaffo",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[10],
                Colors.blue,
                "Damja Charles",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[1],
                Colors.yellow,
                "Doumtsop beaurel",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[0],
                Colors.green,
                "Tchana audrey",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[2],
                Colors.purple,
                "Tafo Romaric",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[3],
                Colors.pinkAccent,
                "Tchoffo Josselin",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[4],
                Colors.indigo,
                "Lacpa Junior",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
            resto(list_image_asset[5],
                Colors.red,
                "Mambou madeleine",
                "Je suis etudiant a ysem depuis 2020 comme boursier de l'honorable Wa Mathurin"),
          ],
        ),
      ),
    );
  }
}
