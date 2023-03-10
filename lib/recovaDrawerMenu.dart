import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';


class RecoverDrawerMenu extends StatefulWidget {
  const RecoverDrawerMenu({Key? key}) : super(key: key);

  @override
  _RecoverDrawerMenuState createState() => _RecoverDrawerMenuState();
}

class _RecoverDrawerMenuState extends State<RecoverDrawerMenu> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 200,
          width: 100,
          color: Colors.white,
          child: const Center(
            child: Text(
              "@RECOVA", style: TextStyle(color: recovaColor, fontSize: 50),
            ),
          ),
        ),
        Container(
          color: recovaColor,
          child: Column(
            children: [
              ListTile(
                title: const Text("RECOVA WEB",
                style: TextStyle(color: Colors.white, fontSize: 20),),
                onTap: (){
                Navigator.pop(context);
              },
                leading: const Icon(Icons.web, color: Colors.white,),
              ),
              ListTile(title: const Text("A propos de nous",
                style: TextStyle(color: Colors.white, fontSize: 20),), onTap: (){
                Navigator.pop(context);
              },
                leading: const Icon(Icons.people_alt_outlined, color: Colors.white,),
              ),
              ListTile(title: const Text("Nous contacter",
                style: TextStyle(color: Colors.white, fontSize: 20),), onTap: (){
                Navigator.pop(context);
              },
                leading: const Icon(Icons.mail, color: Colors.white,),
              ),
              ListTile(title: const Text("Nous suivre sur les réseaux",
                style: TextStyle(color: Colors.white, fontSize: 20),), onTap: (){
                Navigator.pop(context);
              },
                leading: const Icon(Icons.follow_the_signs_outlined, color: Colors.white,),
              ),
              ListTile(title: const Text("Nous noter sur le store",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ), onTap: (){
                Navigator.pop(context);
              },
                leading: const Icon(Icons.star_border, color: Colors.white,),
              ),
            ],
          ),
        ),
      ],);
  }
}
