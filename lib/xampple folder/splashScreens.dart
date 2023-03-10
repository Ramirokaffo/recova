import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_flutter2/xampple%20folder/SecondScreens.dart';
import 'package:projet_flutter2/main.dart';
import 'package:projet_flutter2/xampple%20folder/Transitions.dart';
import 'package:projet_flutter2/ConstantFile.dart';// import 'package:async/async.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          "SecondScreen":(BuildContext context)=>SecondScreen(),
          "recova":(BuildContext context)=>const RecovaHomePage()
        },
        home: soir()
    );
  }
}
class soir extends StatefulWidget {
  @override
  _soirState createState() => _soirState();
}

class _soirState extends State<soir> with SingleTickerProviderStateMixin {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
late AnimationController controller;
late Animation <double> animation;

void navigatorPage()=>Navigator.of(context).pushReplacementNamed("recova");

starTimer() async {
  Duration duration = const Duration(seconds: 5);
  return Timer(duration, navigatorPage);
}

afterTime() async {
  Duration duration = const Duration(seconds: 20);
  return Timer(duration, () { print("Ca fait deja 20 seconde donc je m'execute");});
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
    duration: Duration(milliseconds: 1000),
    reverseDuration: Duration(milliseconds: 1000),);
    animation = Tween(begin: -0.9, end: 0.9).animate(controller)
      ..addListener(() {
        setState(() {
print("object");
        });
      });
    starTimer();
    afterTime();
    controller.forward();
  }


  void dispose(){
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(info),
      // ),
      body: Stack(
        children: <Widget>[
        background(list_image_asset[5]),
          colorbackground(),
          SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 155,),
                    transition(controller, "Bonjour je m'appelle Ramiro Kaffo Dzeuyo Sonny depuis Babadjou"),

                  ],
                ),
              ),))
        ],
      )
    );
  }
}




Widget background( String img){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.fill)
    ),
  );
}


Widget colorbackground(){
  return Container(
    color: Colors.black.withOpacity(0.5),
  );
}