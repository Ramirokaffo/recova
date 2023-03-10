import 'dart:async';

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
int index = 0;
double rep = 0.0;
late Timer timer;
List <double> value = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 250), (Timer timer) {
      setState(() {
        rep = value[index + 1];
        index ++;
        if (index == value.length - 1) {
          index = 0;
        }
      });
    });
  }


  Widget rotation(){
    return Container(
      child: Transform.rotate(
          angle: rep,
      origin: Offset(0.0, 0.0),
      child: Container(
        child: Image(image: AssetImage(list_image_asset[4],),width: 150, height: 150,),
      ),),
    );
  }
  Widget scale(){
    return Container(
      child: Transform.scale(
      scale: rep==0?0:rep/50,
      origin: Offset(0.0, 0.0),
      child: Container(
        child: Image(image: AssetImage(list_image_asset[5],),width: 150, height: 150,),
      ),),
    );
  }
  Widget translate(){
    return Container(
      child: Transform.translate(
      offset: Offset(rep, -rep * 4),
      child: Container(
        child: Image(image: AssetImage(list_image_asset[4],),width: 250, height: 250,),
      ),),
    );
  }

  Widget skew(){
    return Container(
      child: Transform(
      transform: Matrix4.skewX(rep/100),
      child: Container(
        child: Image(image: AssetImage(list_image_asset[3],),width: 250, height: 250,),
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(info),
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: FittedBox(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                scale(),
                rotation(),
                skew(),
                translate()
              ],
            ),
          ),
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
