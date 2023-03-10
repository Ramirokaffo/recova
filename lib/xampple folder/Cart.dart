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
      ),
      body: Center(
          child: Card(
            elevation: 50,
        borderOnForeground: true,
        color: Colors.orange,
        shadowColor: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue,
                size: 30,
              ),
              title: Text("Ramiro application", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text("Ca c'est mon card", style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            Divider(height: 16, color: Colors.black,),
            ListTile(
              leading: Icon(
                Icons.phone_android,
                color: Colors.blue,
                size: 30,
              ),
              title: Text("Telephone perdu", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text("Itel A56 8GB", style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            Divider(height: 16, color: Colors.black,),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.blue,
                size: 30,
              ),
              title: Text("E-mail", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              subtitle: Text("Envoyé à : Ramiro kaffo", style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            ButtonBarTheme(
                data: ButtonBarThemeData(
                    alignment: MainAxisAlignment.center),
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(onPressed: (){},
                        child: Text("Video")),
                    FlatButton(onPressed: (){},
                        child: Text("SMS"))
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
