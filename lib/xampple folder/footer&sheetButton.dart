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
  var value = "";


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
  void show(String a) => setState(()=> value=a);
  void bouton_sheet(){
    showModalBottomSheet(context: context, builder: (BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Tutoriel ")
        ],
      ),
    );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: Icon(Icons.fastfood,size: 15,),
        actions: <Widget>[
          // Icon(Icons.file_download,size: 15,),
          // Icon(Icons.file_upload,size: 15,),
          IconButton(onPressed: soustraction, icon: Icon(Icons.file_download), color: Colors.white,),
          IconButton(onPressed: ajout, icon: Icon(Icons.file_upload), color: Colors.white,),
        ],
      ),
      persistentFooterButtons: <Widget>[
        IconButton(onPressed: ()=>show("Map zoom"), icon: Icon(Icons.zoom_in),),
        IconButton(onPressed: ()=>show("Credit info"), icon: Icon(Icons.account_balance_wallet),),
        IconButton(onPressed: ()=>show("Info bank"), icon: Icon(Icons.add_comment),),
      ],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: bouton_sheet, child: Text("Cliquez ici"
            ),),
            Text("Resultat : $j", style: TextStyle(color: Colors.green, fontSize: 20, ),),
            Padding(padding: EdgeInsets.only(top: 15)),
            Text("$j", style: TextStyle(color: Colors.yellow, fontSize: 40, ),),
            Text("$value", style: TextStyle(color: Colors.yellow, fontSize: 40, ),)
          ],
        ),
      ),
    );
  }
}
