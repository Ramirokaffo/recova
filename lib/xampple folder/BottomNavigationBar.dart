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
  bool val1 = false;
  bool val2 = false;
  double val3 = 0.0;
  int _id = 0;
  String _value = "";

  var j = 0;

  late List <BottomNavigationBarItem> _item;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _item = [];
    _item.add(BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.purple,), label: "Personne", backgroundColor: Colors.green),);
    _item.add(BottomNavigationBarItem(icon: Icon(Icons.camera_alt, color: Colors.purple,), label: "Camera"));
    _item.add(BottomNavigationBarItem(icon: Icon(Icons.wallet, color: Colors.purple,), label: "Wallet"));
    _item.add(BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart_rounded, color: Colors.purple,), label: "Shopping"));

    // info = "Bienvenue sur le tuto";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Application de test"),
            Padding(padding: EdgeInsets.all(20)),
            Text("Vous avez cliqué sur $_value")
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.yellow),
          backgroundColor: Colors.black,
          items: _item,
        currentIndex: _id,
        onTap: (int item){
            setState(() {
              _id = item;
              _value = "Clic sur ${_id.toString()}";
            });
        },

      ),
    );
  }
}
