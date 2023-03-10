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
        home: PageViewer()
    );
  }
}

class PageViewer extends StatefulWidget {
  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
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
        body: PageView.builder(
            itemBuilder: (BuildContext context, int index) =>
Pagewidget(entry: pages[index], key: UniqueKey(),),
          itemCount: pages.length,
        )
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Switch(value: val1, onChanged: change1, activeColor: Colors.green,),
      //
      //       SwitchListTile(value: val2, onChanged: change2, activeColor: Colors.blue,
      //         title: Text("Cameroun"),
      //         subtitle: Text("Yaoundé"),),
      //       Slider(value: val3, onChanged: change3)
      //     ],
      //   ),
      // ),
    );
  }
}

class PageInfo {
  final String title;
  final String image;
  final String description;
  // List list_image = [
  //   "4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  //   "6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  //   "6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  //   "9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  //   "21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  //   "520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  //   "950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  //   "73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  //   "A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  //   "CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  //   "ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  //   "FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"];

  const PageInfo(this.title, this.image, this.description);
}

final List<PageInfo> pages = [
  const PageInfo("Meilleurs module 1",
      "/Users/user/StudioProjects/projet_flutter2/images/4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
      "Ma photo"),
  const PageInfo("Meilleurs module 2",
      "/Users/user/StudioProjects/projet_flutter2/images/6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
      "La photo de valentine"),
  const PageInfo("Meilleurs module 3",
      "/Users/user/StudioProjects/projet_flutter2/images/520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
      "la photo de l'enfant"),
  const PageInfo("Meilleurs module 4",
      "/Users/user/StudioProjects/projet_flutter2/images/9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
      "la photo de l'enfant"),
  const PageInfo("Meilleurs module 5",
      "/Users/user/StudioProjects/projet_flutter2/images/21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
      "la photo de l'enfant"),
  const PageInfo("Meilleurs module 6",
      "/Users/user/StudioProjects/projet_flutter2/images/FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg",
      "la photo de l'enfant"),
  const PageInfo("Meilleurs module 7",
      "/Users/user/StudioProjects/projet_flutter2/images/73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
      "la photo de l'enfant"),
];

class Pagewidget extends StatefulWidget {
  final PageInfo entry;

  const Pagewidget({required Key key, required this.entry}) : super(key: key);

  @override
  _PageWidgetState createState() => _PageWidgetState();
}

class _PageWidgetState extends State<Pagewidget> {
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Row(
              children: <Widget>[
                Text(widget.entry.title,
                  style: const TextStyle(color: Colors.blue, fontSize: 25),)
              ]
          ),
          const SizedBox(height: 10,),
          Image.asset(widget.entry.image, fit: BoxFit.cover,),
          const SizedBox(height: 10,),
          Text(widget.entry.description, style: const TextStyle(
              color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}