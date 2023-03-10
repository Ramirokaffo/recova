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
        home: HeroAnimation());
  }
}

class HeroAnimation extends StatefulWidget {
  @override
  _HeroAnimationState createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  List<Container> movieOscar = [];
  var poster = [
    {"Name": "IO", "Photo": list_image_asset[5]},
    {"Name": "The shape of water", "Photo": list_image_asset[6]},
    {"Name": "Green book", "Photo": list_image_asset[7]},
    {"Name": "Grejen book", "Photo": list_image_asset[7]},
    {"Name": "Grelen book", "Photo": list_image_asset[7]},
    {"Name": "Grpeen book", "Photo": list_image_asset[7]},
    {"Name": "Grjeen book", "Photo": list_image_asset[7]},
    {"Name": "Greven book", "Photo": list_image_asset[7]},
    {"Name": "Green bopok", "Photo": list_image_asset[7]},
    {"Name": "Green bmook", "Photo": list_image_asset[7]},
    {"Name": "Green bhook", "Photo": list_image_asset[7]},
    {"Name": "Vandavme", "Photo": list_image_asset[1]},
    {"Name": "Jegt lee", "Photo": list_image_asset[0]},
    {"Name": "Rambo", "Photo": list_image_asset[2]},
    {"Name": "Anaconda", "Photo": list_image_asset[3]},
    {"Name": "Kaffo ramiro", "Photo": list_image_asset[4]},
    {"Name": "Lougi fonsi", "Photo": list_image_asset[8]},
    {"Name": "Louvi fonsi", "Photo": list_image_asset[8]},
    {"Name": "Louri fonsi", "Photo": list_image_asset[8]},
    {"Name": "Lowui fonsi", "Photo": list_image_asset[8]},
    {"Name": "Loui fconsi", "Photo": list_image_asset[8]},
    {"Name": "Loui fmonsi", "Photo": list_image_asset[8]},
    {"Name": "Loui fojnsi", "Photo": list_image_asset[8]},
    {"Name": "Loui foznsi", "Photo": list_image_asset[8]},
    {"Name": "Loui foensi", "Photo": list_image_asset[8]},
    {"Name": "Loui foqnsi", "Photo": list_image_asset[8]},
  ];

  buildList() async {
    for (var i = 0; i < poster.length; i++) {
      final gleinfo = poster[i];
      final String imageposter = gleinfo["Photo"];
      int pourcent = 85 + i;
      movieOscar.add(Container(
        padding: EdgeInsets.all(15),
        child: Card(
          elevation: 5.0,
          child: Column(
            children: <Widget>[
              Container(
                child: Hero(
                    tag: gleinfo["Name"],
                    child: Material(
                      child: InkWell(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context)=>ShowDetails(
                              namedetail: gleinfo["Name"],
                              posterdetails: imageposter,
                          pcent: pourcent,)
                        )
                      ),
                        child: Container(
                          height: 127,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(imageposter),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ));
      Text(
        gleinfo["Name"],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(info),
        ),
        body: Container(
          child: GridView.count(
            crossAxisCount: 2,
            children: movieOscar,
          ),
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

class ShowDetails extends StatelessWidget {
  final String namedetail, posterdetails;
  final pcent;

  const ShowDetails(
      {required this.namedetail, required this.posterdetails, this.pcent});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.movie_creation))
        ],
        title: Text(
          namedetail,
          style: const TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 200,
            height: 565,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage(posterdetails), fit: BoxFit.cover),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.red,
                              size: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Play Trialer",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "$pcent% Liked this files",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const Icon(
                              Icons.thumb_up,
                              color: Colors.blueAccent,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.thumb_down,
                              color: Colors.redAccent,
                              size: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: const <Widget>[
                        Text(
                          "A look at three defining chapters in file of chiron",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
