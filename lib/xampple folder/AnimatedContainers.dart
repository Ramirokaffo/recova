import 'package:flutter/material.dart';
import 'package:projet_flutter2/main.dart';
import 'package:projet_flutter2/ConstantFile.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Animated()
    );
  }
}
class Animated extends StatefulWidget {
  @override
  _AnimatedState createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  double height = 150;
  double width = 200;

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.green[900]!,
                Colors.green[700]!,
                Colors.green[500]!,
              ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(list_image_asset[9], height: 140, width: 130,),
                Image.asset(list_image_asset[1], height: 140, width: 130,),
                Image.asset(list_image_asset[5], height: 140, width: 130,),
              ],
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(left: 40, right: 40),
                        child: Text("Mes photos",
                          style: TextStyle(color: Colors.green, fontSize: 50),),),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    OutlinedButton(
                                        onPressed: (){
                                          setState(() {
                                            height += 100;
                                            width += 100;
                                          });
                                        },
                                      // style: ButtonStyle(),
                                        child: const Icon(Icons.zoom_in, size: 30, color: Colors.green,),
                                    ),
                                    AnimatedContainer(duration: Duration(seconds: 1),
                                    curve: Curves.ease,
                                    height: height,
                                    width: width,
                                    child: Image.asset(list_image_asset[2], height: 150, width: 200,)),
                                    OutlinedButton(
                                      onPressed: (){
                                        setState(() {
                                          if (height>100 || width>100){
                                          height -= 100;
                                          width -= 100;}
                                        });
                                      },
                                      // style: ButtonStyle(),
                                      child: const Icon(Icons.zoom_out, size: 30, color: Colors.green,),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(list_image_asset[3], height: 150, width: 200,),
                              Image.asset(list_image_asset[4], height: 150, width: 200,),
                              Image.asset(list_image_asset[6], height: 150, width: 200,),
                              Image.asset(list_image_asset[7], height: 150, width: 200,),
                              Image.asset(list_image_asset[8], height: 150, width: 200,),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
            )
          ],
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
