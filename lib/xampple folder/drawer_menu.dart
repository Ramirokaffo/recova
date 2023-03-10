import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
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
  var info = "Bienvenue chez ramiro";
  var welcome = "Bienvenue sur mon application";
  bool val1 = false;
  bool val2 = false;
  double val3 = 0.0;


  var j = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }
  void change1(bool s){
    setState(() {
      val1 = s;
    });
  }
  void change2(bool t){
    setState(() {
      val2 = t;
    });
  }
  void change3(double f){
    setState(() {
      val3 = f;
    });
  }
  void ajout(){
    setState(() {
      j++;
    });
  }
  void soustraction(){
    setState(() {
      j--;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: Icon(Icons.fastfood,size: 25,),
        actions: <Widget>[
          // Icon(Icons.file_download,size: 15,),
          // Icon(Icons.file_upload,size: 15,),
          IconButton(onPressed: soustraction, icon: Icon(Icons.file_download, size: 35,), color: Colors.white,),
          IconButton(onPressed: ajout, icon: Icon(Icons.file_upload, size: 35,), color: Colors.white,),
        ],
      ),
      drawer: ListView(padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            child: Text(
              "Progr. & Framework", style: TextStyle(color: Colors.orange),
            ),
            decoration: BoxDecoration(color: Colors.black),
        ),
        ListTile(title: Text("DART"), onTap: (){
          Navigator.pop(context);
        },),
        ListTile(title: Text("JAVA"), onTap: (){
          Navigator.pop(context);
        },),
        ListTile(title: Text("KOTLIN"), onTap: (){
          Navigator.pop(context);
        },),
        ListTile(title: Text("SWIFT"), onTap: (){
          Navigator.pop(context);
        },),
        ListTile(title: Text("Objective C"), onTap: (){
          Navigator.pop(context);
        },),
      ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text("Resultat : $j", style: TextStyle(color: Colors.green, fontSize: 20, ),),
            // Padding(padding: EdgeInsets.only(top: 15)),
            // Text("$j", style: TextStyle(color: Colors.yellow, fontSize: 40, ),)
          ],
        ),
      ),
    );
  }
}
