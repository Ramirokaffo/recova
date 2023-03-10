import 'package:flutter/material.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: soir());
//   }
// }

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
      body: Stack(
        // alignment: Alignment.topRight,
        children: <Widget>[
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.yellow,
                ),
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              height: 500,
              width: 300,
              color: Colors.green,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch, //Etirement
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        height: 200,
                        width: 100,
                        color: Colors.orange,
                      ),
                      Container(
                        height: 200,
                        width: 100,
                        color: Colors.purple,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
