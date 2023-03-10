import 'package:flutter/material.dart';
import 'package:projet_flutter2/xampple folder/Background.dart';
// import 'package:projet_flutter2/main.dart';
// import 'package:projet_flutter2/Transitions.dart';
import 'package:projet_flutter2/xampple%20folder/BouttonInfoLogin.dart';
import 'package:projet_flutter2/ConstantFile.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = Tween(begin: 0.0, end: 0.9).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background(list_image_asset[4]),
          colorbackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0.0, -0.9), end: Offset.zero)
                        .animate(controller),
                    child: const TextField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          labelText: "Login",
                          hintText: "Entrez votre login",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blueGrey,
                          )),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0.0, -0.9), end: Offset.zero)
                        .animate(controller),
                    child: const TextField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          labelText: "Mot de passe",
                          hintText: "Entrez votre mot de passe",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blueGrey,
                          )),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 50,),
                  SlideTransition(
                    position: Tween<Offset>(
                        begin: const Offset(0.0, -0.9), end: Offset.zero)
                        .animate(controller),
                    child: buttonInfo("Connexion rapide", (){print("Acces direct");}),
                  ),
                  const SizedBox(height: 50,),
                  FadeTransition(
                      opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                          begin: const Offset(0.0, -0.6), end: Offset.zero)
                          .animate(controller),
                      child: buttonInfo("Creation de compte", (){print("Create account");}),
                    ),
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
