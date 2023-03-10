import 'dart:ui';

import 'package:flutter/material.dart';

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
        home: BackDropFilter()
    );
  }
}
class BackDropFilter extends StatefulWidget {
  @override
  _BackDropFilterState createState() => _BackDropFilterState();
}

class _BackDropFilterState extends State<BackDropFilter> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";

  Widget resto (String menu, Color color, String image){
    return Container(
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(image, height: 150, width: 150,),
          Text(menu, style: TextStyle(color: Colors.white, fontSize: 40),)

        ],
      ),
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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(info),
      // ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:   BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                      image: AssetImage("/Users/user/StudioProjects/projet_flutter2/images/${list_image[5]}")
                      // image: NetworkImage('https://picsum.photos/250?image=9',),

                  )
              ),
            ),
            Positioned(
              top: 100,
              right: 50,
              left: 50,
              bottom: 100,
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.blue.withOpacity(0.5),
                        child: Column(
                          children: const <Widget>[
                            Padding(padding: EdgeInsets.only(top: 50)),
                            Text("Mon BackDropFilter", style: TextStyle(color: Colors.yellow, fontSize: 30),),
                            SizedBox(height: 30,),
                            Text("Ramiro kaffo dzeuyo sony", style: TextStyle(color: Colors.yellow, fontSize: 30),textAlign: TextAlign.center,)
                          ],
                        ),
                  ),
                ),
              ),
            )
          ],
        )
      // CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       title: Text("Mon Sliver AppBar"),
      //       centerTitle: true,
      //       pinned: true,
      //       floating: false,
      //       expandedHeight: 400,
      //       backgroundColor: Colors.transparent,
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Image.asset("/Users/user/StudioProjects/projet_flutter2/images/4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg", fit: BoxFit.cover,),
      //       ),
      //       actions: const <Widget>[
      //         IconButton(onPressed: null, icon: Icon(Icons.account_balance_wallet, color: Colors.blue,))
      //       ],
      //     ),
      //     SliverFixedExtentList(
      //         itemExtent: 150,
      //       delegate: SliverChildListDelegate(
      //         [
      //           resto ("Spageti", Colors.blue, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[5]}"),
      //           resto ("Taro", Colors.red, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[6]}"),
      //           resto ("Cous-cous", Colors.green, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[7]}"),
      //           resto ("Le eru", Colors.yellow, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[8]}"),
      //           resto ("Le eru", Colors.orange, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[9]}"),
      //           resto ("Le eru", Colors.purple, "/Users/user/StudioProjects/projet_flutter2/images/${list_image[10]}"),
      //         ],
      //       ),
      //     )
      //   ],
      // )
    );
  }
}
