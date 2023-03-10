import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        home: SatagarredGridViews()
    );
  }
}
class SatagarredGridViews extends StatefulWidget {
  @override
  _SatagarredGridViewsState createState() => _SatagarredGridViewsState();
}

class _SatagarredGridViewsState extends State<SatagarredGridViews> {
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
      body: Container(
        margin: EdgeInsets.all(10),
        child: MasonryGridView.count(
          mainAxisSpacing: 5.0,
            crossAxisSpacing: 5,
            crossAxisCount: 2,
            primary: false,
            shrinkWrap: true,
            itemCount: Infos.length,
            itemBuilder: (BuildContext context, int index){
            return Showinfo(
                verif: Infos[index],
            );
            },

            ),

        ),
      );

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //     ],
      //   ),
      // ),
    // );
  }
}


class Info {
  String images;
  String titles;
  String city;
  Info({required this.images, required this.titles, required this.city});
}

List <Info> Infos = [
  Info(images: list_image_asset[0], titles: "Cameroun-Yaoundé", city: "Douala"),
  Info(images: list_image_asset[1], titles: "Baffoussam-Mbouda", city: "Douala"),
  Info(images: list_image_asset[2],titles: "Bamenda-Kribi", city: "Douala"),
  Info(images: list_image_asset[3],titles: "Bamboutos-Babadjou", city: "Mbouda"),
  Info(images: list_image_asset[4],titles: "Babadjou-Toumaka", city: "Ndoji"),
  Info(images: list_image_asset[5],titles: "Galim-Bati", city: "Ouest"),
  Info(images: list_image_asset[6],titles: "Extreme-Nord-Maroua", city: "Douala"),
  Info(images: list_image_asset[7],titles: "Nord-Garoua", city: "Cameroun"),
  Info(images: list_image_asset[8],titles: "Tchad-Djamena", city: "Lac Tchad"),
  Info(images: list_image_asset[9],titles: "Sanaga-Yaoundé", city: "Le plus long fleuve"),
  Info(images: list_image_asset[10],titles: "Mont-Cameroun", city: "Le plus haut sommet"),
  Info(images: list_image_asset[11],titles: "Mont-Bamboutos", city: "Ouest-cameroun"),
  Info(images: list_image_asset[1],titles: "Mont-Kilimendjaro", city: "Le plus haut sommet"),
  Info(images: list_image_asset[4],titles: "Mont-Everest", city: "Monde"),
  Info(images: list_image_asset[5],titles: "Le Nil", city: "Afrique"),
  Info(images: list_image_asset[8],titles: "Atlantique-Afrique", city: "Ocean"),
];

class Showinfo extends StatelessWidget{
  final Info verif;

  const Showinfo({super.key, required this.verif});
  Widget build(BuildContext context) {
    return Column(
children: <Widget>[
   ClipRRect(
     borderRadius: BorderRadius.circular(18),
       child: Image.asset(verif.images)
   ),
  Text(verif.titles, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

  Text(verif.city, style: TextStyle(fontSize: 10),),
  SizedBox(height: 30,)
],
    );
  }
}