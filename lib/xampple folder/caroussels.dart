import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';

List list_image = [
  "4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"];


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Carroussels());
  }
}

class Carroussels extends StatefulWidget {
  @override
  _CarrousselsState createState() => _CarrousselsState();
}

class _CarrousselsState extends State<Carroussels> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  int max = 10;

  Widget imageCarossel = Container(
    height: 150,
    child: Carousel(
      boxFit: BoxFit.fill,
      images: [
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[1]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[2]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[3]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[4]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[5]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[6]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[7]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[8]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[9]}"),
        AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[10]}"),
      ],
    ),
  );
  String value = "";
  var j = 0;
  String name = "";
  String phone = "";
  String password = "";

  final formkey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }

  // void submit(a) {
  //   setState(() {
  //     value = "message envoyé: $a";
  //   });
  // }

  void affiche(b) {
    setState(() {
      value = "Bienvenue: $b";
      if (b.length == 20) {
        max = 0;
      }
    });
  }

  validation_form() {
    if (formkey.currentState!.validate()) {
      formkey.currentState?.save();
      debugPrint(name);
      debugPrint(phone);
      debugPrint(password);
      formkey.currentState?.reset();
    } else {
      (debugPrint("Error........"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(info),
      // ),

      body: ListView(
        children: <Widget>[
          imageCarossel,
        Form(
          key: formkey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Nom",
                      hintText: "Veuillez entrer votre nom",
                      icon: Icon(
                        Icons.person,
                        size: 25,
                        color: Colors.blue,
                      )),
                  validator: (val) =>
                  val?.length == 0 ? "Validez votre nom" : null,
                  onSaved: (val) => name = val!,
                  keyboardType: TextInputType.text,
                  autocorrect: true,
                  autofocus: true,
                  onChanged: affiche,
                  // onSubmitted: submit,
                  maxLength: max,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Numero",
                      hintText: "Veuillez entrer votre numero de telephone",
                      icon: Icon(
                        Icons.phone,
                        size: 25,
                        color: Colors.blue,
                      )),
                  validator: (val) => val?.length == 0
                      ? "Validez votre numero de teleohone"
                      : null,
                  onSaved: (val) => phone = val!,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Veuillez entrer votre mot de passe",
                      icon: Icon(
                        Icons.lock,
                        size: 25,
                        color: Colors.red,
                      )),
                  validator: (val) =>
                  val?.length == 0 ? "Validez votre mot de passe" : null,
                  onSaved: (val) => password = val!,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                TextButton(
                  onPressed: validation_form,
                  child: const Text(
                    "Validation",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }
}
