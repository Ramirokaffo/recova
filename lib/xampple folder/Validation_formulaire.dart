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
  int max = 10;
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
      appBar: AppBar(
        title: Text(info),
      ),
      body: Form(
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
              RaisedButton(
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
    );
  }
}
