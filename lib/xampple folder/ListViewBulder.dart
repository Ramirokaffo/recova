import 'dart:js';

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
      body: Container(
        child: getListView(),
      ),
    );
  }
}

List <String> get_list_element() {
  var item = List<String>.generate(25, (index) => "Article : $index");
  return item;
}

Widget getListView() {
  var listItem = get_list_element();
  var listview = ListView.builder(
    itemCount: listItem.length,
    itemBuilder: (context, val) {
      return ListTile(
        title: Text(
          listItem[val],
          style: TextStyle(fontSize: 15, color: Colors.red),),
        leading: Icon(Icons.image, color: Colors.blue,),
        onTap: (){
          debugPrint("Valeur active ${listItem[val]}");
        },
      );
    },
  );
  return listview;
}