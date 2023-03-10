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

  List <DropdownMenuItem<String>> listmounths = [];

  String? def = null;

  void mounths(){
    listmounths.clear();
    listmounths.add(
      const DropdownMenuItem(
        value: "Janvier",
        child: Text("Janvier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Fevrier",
        child: Text("Fevrier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      ),
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Mars",
        child: Text("Mars", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Avril",
        child: Text("Avril", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Mai",
        child: Text("Mai", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Juin",
        child: Text("Juin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Juillet",
        child: Text("Juillet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Aout",
        child: Text("Aout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Septembre",
        child: Text("Septembre", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Octobre",
        child: Text("Octobre", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Novembre",
        child: Text("Novembre", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
    );
    listmounths.add(
      const DropdownMenuItem(
        value: "Decembre",
        child: Text("Decembre", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
      )
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
    mounths();
    return Scaffold(

      appBar: AppBar(
        title: Text(info),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: DropdownButton(
                  dropdownColor: Colors.cyan,
                    value: def,
                    elevation: 10,
                    items: listmounths,
                    hint: Text("Selectionner le mois", style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),),
                    onChanged:(String? value) {
                      def = value;
                      setState(() {

                      });
                    }),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Text("Votre mois selectionne est: $def", style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
