import 'package:flutter/material.dart';

var directory = "/Users/user/StudioProjects/projet_flutter2/images/";
List list_image_asset = [
  "${directory}4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "${directory}6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "${directory}6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "${directory}9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "${directory}21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "${directory}520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "${directory}950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "${directory}73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "${directory}A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "${directory}CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "${directory}ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "${directory}FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
];

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
  bool change = true;
  String a = list_image_asset[6];
  String b = list_image_asset[7];
  String c = list_image_asset[8];
  String d = list_image_asset[9];

  void onSubmit(String value){
    setState(() {
      infos = value;
    });
  }

String infos = "";
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Mouvement de la souris : $infos", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
Row(
  children: <Widget>[
    Image.asset(change?a:b,width: 200, height: 200,),
    Image.asset(change?b:c,width: 200, height: 200,),
  ],
),
            
            // GestureDetector(
        InkWell(
              onTap: (){
                setState(() {
                  if (change = true){
                    change = false;
                    onSubmit("Vous avez un clic");
                  } else {
                    change = true;
                  }
                });
              },
              onDoubleTap: (){
                setState(() {
                  if (change = true){
                    change = true;
                    onSubmit("Vous avez un double clic");
                  } else {
                    change = false;
                  }
                });
              },
              onLongPress: (){
                setState(() {
                  if (change = true){
                    change = true;
                    onSubmit("Vous avez un long clic");
                  } else {
                    change = false;
                  }
                });
              },
              onTapCancel: (){
                onSubmit("Clic annulé");
              },
              child: Container(
                height: 50,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(15)),
                child: Text("Validation", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
