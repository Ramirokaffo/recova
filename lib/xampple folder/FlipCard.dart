import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
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
  String front1 = list_image_asset[0];
  String back1 = list_image_asset[1];
  String front2 = list_image_asset[2];
  String back2 = list_image_asset[3];
  String front3 = list_image_asset[4];
  String back3 = list_image_asset[5];
  String front4 = list_image_asset[6];
  String back4 = list_image_asset[7];
  String front5 = list_image_asset[8];
  String back5 = list_image_asset[9];


  Widget affichage( String frontImage, String backImage, FlipDirection direction,
      double h, double w){
    return Container(
      height: h,
      width: w,
      padding: const EdgeInsets.all(11),
      child: FlipCard(
        direction: direction,
          front: Material(
            child: Container(
              decoration: BoxDecoration(
                image:  DecorationImage(image: AssetImage(frontImage),
                    fit: BoxFit.cover)
              ),
            ),
          ),
          back: Material(
            child: Container(
              decoration: BoxDecoration(
                  image:  DecorationImage(image: AssetImage(backImage),
                      fit: BoxFit.cover)
              ),
            ),
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
              affichage(front1, back1, FlipDirection.HORIZONTAL, 600, 700),
              affichage(front2, back2, FlipDirection.VERTICAL, 500, 500),
              affichage(front3, back3, FlipDirection.HORIZONTAL, 400, 600),
              affichage(front4, back4, FlipDirection.VERTICAL, 600, 700),
              affichage(front5, back5, FlipDirection.HORIZONTAL, 700, 500),
              // affichage(front1, back1, FlipDirection.HORIZONTAL, 600, 700),
                  ],
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
