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

  LinearGradient getLG() {
    return const LinearGradient(
      colors: [
        Color(0xFFFFFFFF),
        Color(0xff0498f8),
        Colors.red,
      ],
      begin: FractionalOffset(0.0, 0.0),
      //Alignment.center,
      end: Alignment.centerRight,
      stops: [0.3, 0.7, 0.3],
      tileMode: TileMode.decal,
    );
  }

  RadialGradient getRG() {
    return const RadialGradient(
        colors: [
          Colors.purple,
          Colors.deepPurple,
          Colors.purple,
          Colors.white
        ],
        center: Alignment.topRight,
        radius: 1.1,
        tileMode: TileMode.mirror,
        stops: [0.1, 0.3, 0.1, 0.1]);
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
        // appBar: AppBar(
        //   title: Text(info),
        // ),
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: getRG(),
          ),
        ),
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
