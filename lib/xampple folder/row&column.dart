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
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Expanded(
              //     child:
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Text(
                      "West jet",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "De yaounde a douala passant par bafossam",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ))
                ],
              ),
              // ),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Text(
                      "YSEM",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                      child: Text(
                        "Youande highger school of economics and management",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "CEMAC",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                      child: Text(
                        "Communauté économique et monaiteire de l'afrique central",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ))
                ],
              ),
            ],
          ),
          // child: Row(
        ),
      ),
    );
  }
}
