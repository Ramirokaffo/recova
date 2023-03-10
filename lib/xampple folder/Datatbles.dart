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
  late List <Geo> Geos;
  void initState(){
    // @override
    Geos = Geo.getgeo();
    super.initState();
  }

  Widget tableau_geo(){
    return DataTable(
        columns: [
          DataColumn(label: Text("Pays", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),)),
          DataColumn(label: Text("Capital", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),)),
          DataColumn(label: Text("Continent", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),))
        ],
        rows: Geos.map((geo)=>DataRow(
            cells: [DataCell(Text(geo.pays)),
          DataCell(Text(geo.capitale)),
          DataCell(Text(geo.continent)),
      ]
        )
    ).toList()
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            tableau_geo()

          ],
        ),
      ),
    );
  }
}

class Geo {
  String pays;
  String capitale;
  String continent;

  Geo({required this.pays, required this.capitale, required this.continent});
  static List<Geo> getgeo(){
    return<Geo>[
      Geo(pays: "Canada", capitale: "Ottawa", continent: "Amerique"),
      Geo(pays: "Cameroun", capitale: "Yaoundé", continent: "Afrique"),
      Geo(pays: "USA", capitale: "Washington", continent: "Amerique"),
      Geo(pays: "Chine", capitale: "Pekin", continent: "Amerique"),
      Geo(pays: "Ruissie", capitale: "Moscou", continent: "Europe"),
      Geo(pays: "Royaume-uni", capitale: "Londre", continent: "Europe"),
      Geo(pays: "Japon", capitale: "Tokyo", continent: "Asie"),
      Geo(pays: "Egypte", capitale: "Le caire", continent: "Afrique"),
      Geo(pays: "Senegal", capitale: "Dakar", continent: "Afrique"),
      Geo(pays: "Cote d'ivoire", capitale: "Brasaville", continent: "Afrique"),
      Geo(pays: "Bresil", capitale: "Brasilla", continent: "Amerique"),
      Geo(pays: "Fidji", capitale: "Suva", continent: "Oceanie"),
      Geo(pays: "Allemagne", capitale: "Berlin", continent: "Europe"),
    ];
  }
}