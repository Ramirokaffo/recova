import 'package:flutter/material.dart';
import 'package:projet_flutter2/xampple%20folder/StaggeredGridViews.dart';
// import 'package:charts_flutter/flutter.dart';

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
  final List<ListInfo> executer = [
    ListInfo(list_image_asset[0], "Recuperer le lait", "12/07/2020", Colors.orange),
    ListInfo(list_image_asset[1], "Recuperer le lait", "12/07/2020", Colors.cyanAccent),
    ListInfo(list_image_asset[2], "Recuperer le lait", "12/07/2020", Colors.blueAccent),
    ListInfo(list_image_asset[3], "Recuperer le lait", "12/07/2020", Colors.red),
    ListInfo(list_image_asset[4], "Recuperer le lait", "12/07/2020", Colors.purpleAccent),
    ListInfo(list_image_asset[5], "Recuperer le lait", "12/07/2020", Colors.pink),
    ListInfo(list_image_asset[6], "Recuperer le lait", "12/07/2020", Colors.brown),
    ListInfo(list_image_asset[7], "Recuperer le lait", "12/07/2020", Colors.pinkAccent),
    ListInfo(list_image_asset[8], "Recuperer le lait", "12/07/2020", Colors.teal),
    ListInfo(list_image_asset[9], "Recuperer le lait", "12/07/2020", Colors.black),
    ListInfo(list_image_asset[10], "Recuperer le lait", "12/07/2020", Colors.grey),
    ListInfo(list_image_asset[11], "Recuperer le lait", "12/07/2020", Colors.green),
    ListInfo(list_image_asset[1], "Recuperer le lait", "12/07/2020", Colors.amberAccent),
    ListInfo(list_image_asset[0], "Recuperer le lait", "12/07/2020", Colors.blue),
  ];

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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: executer.length,
          itemBuilder: (context, index)
      {
        ListInfo ls = executer[index];
        return Dismissible(
            key: UniqueKey(),
          onDismissed: (direction){
              setState(() {
                executer.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(ls.detailcours + ", Supprimer de la liste"),
              action: SnackBarAction(
                  label: "Annuler",
                  onPressed: () {
                    setState(() {
                      executer.add(ls);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(ls.detailcours + ", Rajouter à la fin de la liste"),),);
                  },),
              ));
          },
          background: Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.delete, size: 25, color: ls.colors,),
                Text("-- ${ls.detailcours} -- Sera supprimé de la liste ",
                style: TextStyle(color: ls.colors, fontSize: 15, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: ls.colors,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Icon(Icons.delete_forever),
              ],
            ),
          ),
            child: Pagewidget(
              entry: executer[index],
              key: Key(ls.detailcours),
            ),
        );
      })
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[],
      //   ),
      // ),
    );
  }
}

class ListInfo {
  final String image;
  final String detailcours;
  final String dates;
  final Color colors;

  ListInfo(this.image, this.detailcours, this.dates, this.colors);
}

class Pagewidget extends StatelessWidget {
  final ListInfo entry;

  const Pagewidget({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    entry.image,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                  Text(
                    entry.detailcours,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    entry.dates,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: entry.colors),
                  ),
                  Container(
                    width: 5, height: 30, color: entry.colors,
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5),
            child: SizedBox(height: 2, width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.grey,
            ),),)
          ],
        ),
      ),
    );
  }
}
