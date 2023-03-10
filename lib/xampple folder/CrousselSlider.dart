import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

List list_image_asset = [
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
        home: CarrousselSliders()
    );
  }
}
class CarrousselSliders extends StatefulWidget {
  @override
  _CarrousselSlidersState createState() => _CarrousselSlidersState();
}

class _CarrousselSlidersState extends State<CarrousselSliders> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  bool val1 = false;
  bool val2 = false;
  double val3 = 0.0;
  List <String> list_image = [];
 late CarouselSlider instance;

String a = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[0]}";
String b = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[1]}";
String c = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[2]}";
String d = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[3]}";
String e = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[4]}";
String f = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[5]}";
String g = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[6]}";
String h = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[7]}";
String i = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[8]}";
String j = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[9]}";
String k = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[10]}";
String l = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[11]}";
String m = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[5]}";
String n = "/Users/user/StudioProjects/projet_flutter2/images/${list_image_asset[6]}";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
    list_image.add(a);
    list_image.add(b);
    list_image.add(c);
    list_image.add(d);
    list_image.add(e);
    list_image.add(f);
    list_image.add(g);
    list_image.add(i);
    list_image.add(j);
    list_image.add(k);
    list_image.add(l);
    list_image.add(m);
    list_image.add(n);
    list_image.add(h);
    list_image.add(a);
  }


  @override
  Widget build(BuildContext context) {
    instance = CarouselSlider(options: CarouselOptions(
      initialPage: 0,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      height: MediaQuery.of(context).size.height - 105
    ), items: list_image.map((x) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(20),
          color: Colors.purple
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(x)
          ],
        ),
      );
    }).toList(),

    );
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text(info),
        actions: <Widget>[
          const IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.near_me)),
        ],
      ),
      body: Column(
        children: <Widget>[
          instance,
        ],
      )
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //     ],
      //   ),
      // ),
    );
  }
}
