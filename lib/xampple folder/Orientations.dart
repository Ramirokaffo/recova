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
        backgroundColor: Colors.black,
        body: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            debugPrint("Portraie");
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children:  <Widget>[
                    infoWeber(),
                    infoPhw(),
                    infotable(),
                    infoshort()
                    // Text(
                    //   "Ramiro kaffo",
                    //   style: TextStyle(color: Colors.red, fontSize: 25),
                    // )
                  ],
                ),
              ),
            );
          } else {
            debugPrint("Paysane");
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    infoWeber(),
                    infoPhw(),
                    infotable(),
                    infoshort()
                    // Text(
                    //   "Tuto flutter",
                    //   style: TextStyle(color: Colors.red, fontSize: 25),
                    // )
                  ],
                ),
              ),
            );
          }
        })
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

  Widget infoWeber() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Meteo Cameroun",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "9 degrés Celcus",
                            style: TextStyle(fontSize: 20, color: Colors.yellow),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          const Text(
                            " ESENTIR COVE 9 degrés Celcus",
                            style: TextStyle(fontSize: 20, color: Colors.yellow),
                          ),
                          Image(
                            image: AssetImage(list_image_asset[5],),width: 200, height: 200,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoPhw() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: const <Widget>[
          Text(
            "Precipitaion : 0%",
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Humidité : 59%",
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Vent : 8Km/h",
            style: TextStyle(
                fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget infotable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          const Text(
            "Nuageux",
            style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold),
          ),
          DataTable(columns: const <DataColumn>[
            DataColumn(
              label: Text(
                "Vent",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Visibilité",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Humidité",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Lever du soleil",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ], rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(ListTile(
                title: Text("7km/h",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold)),
              )),
              DataCell(ListTile(
                title: Text("53%",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold)),
              )),
              DataCell(ListTile(
                title: Text("14Km",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold)),
              )),
              DataCell(ListTile(
                title: Text("06h00",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold)),
              )),
            ])
          ])
        ],
      ),
    );
  }

  Widget infoshort() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("Previsions àcout terme",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Ce soir 18h - 6h 5 degré C",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                      list_image_asset[9],
                    ),width: 200, height: 200,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text("Nuageux avec pluie en soirée",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text("Pluie pendant la nuit. POP 90% Pluie: 5 - 10 mm",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Mercredi 18h30 - 6h15 9 degré C',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image(image: AssetImage(list_image_asset[6]),width: 200, height: 200),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text("Pluie le matin et l'apres midi",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
