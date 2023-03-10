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

  Widget hairimage(String holder, String img) {
    return Container(
      height: 300,
      width: 200,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(75),
          topRight: Radius.circular(75),
        ),

        child: Container(
          child: FadeInImage.assetNetwork(
              placeholder: holder,
              image: img,
          fadeInDuration: Duration(seconds: 10),
            fadeInCurve: Curves.fastLinearToSlowEaseIn,
          ),

        )
      ),
    );
  }

  Widget barby(String infos){
    return Container(
      width: 200,
      height: 30,
      child: Column(
        children: <Widget>[
          Text(
            infos,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple),
          ),
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
            FittedBox(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[2], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[8], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[2], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[8], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[2], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[8], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[2], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[8], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[6], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[5], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[4], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[1], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        hairimage(list_image_asset[0], 'https://picsum.photos/250?image=9'),
                        hairimage(list_image_asset[3], 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        barby("Kaffo Dzeuyo Sony Ramiro"),
                        barby("Etudiant a YSEM"),
                      ],
                    ),
                  ),
                ],
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
