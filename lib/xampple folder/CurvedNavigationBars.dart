import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:projet_flutter2/StaggeredGridViews.dart';
import 'package:mysql_client/mysql_client.dart';
const Color recovaColor = Colors.purple;

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
List usersList = [];
Future <List> objectList = [] as Future<List>;

Future<void> select_users() async {
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "root",
    password: "RECOVA1%",
    databaseName: "recova", // optional
  );

// actually connect to database
  await conn.connect();
  var result = await conn.execute(
      "SELECT * FROM users;");
  for (final row in result.rows) {
    usersList.add(row.assoc());
    print(row.assoc());
  }
}


Future<List> select_objects() async {
  final conn = await MySQLConnection.createConnection(
    host: "127.0.0.1",
    port: 3306,
    userName: "root",
    password: "RECOVA1%",
    databaseName: "recova", // optional
  );

// actually connect to database
  await conn.connect();
  var result = await conn.execute(
      "SELECT * FROM object;");
  // for (final row in result.rows) {
  //   objectList.add(row.assoc());
  //   // print(row.assoc());
  //   // debugPrint(objectList.toString());
  // }
  return result.toList();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          
        ),
        home: Recova());
  }
}

class Recova extends StatefulWidget {
  const Recova({Key? key}) : super(key: key);

  @override
  _RecovaState createState() => _RecovaState();
}

class _RecovaState extends State<Recova> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  int page = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    select_users();
    objectList = select_objects();
    print(objectList.toString());

  }

  @override
  Widget build(BuildContext context) {
    var tab = <Widget>[
      MaterialApp(
          home: DefaultTabController(
              length: 4,

              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white60,
                    toolbarHeight: 30,
                    excludeHeaderSemantics: true,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(tabs: <Widget>[
                      Tab(
                        child: Column(
                          children: const [
                            Icon(Icons.all_inclusive_outlined, color: recovaColor,),
                            Text("Tout", style: TextStyle(color: recovaColor),)
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: const [
                            Icon(Icons.credit_card_sharp, color: recovaColor),
                            Text("CNI", style: TextStyle(color: recovaColor),)
                          ],
                        ),
                      ),
                      Tab(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person,
                              color: recovaColor,
                            ),
                            Text("Personne", style: TextStyle(color: recovaColor),)
                          ],
                        ),

                      ),
                      Tab(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.keyboard_double_arrow_down_outlined,
                              color: recovaColor,
                            ),
                            Text("Autres", style: TextStyle(color: recovaColor),)
                          ],
                        ),

                      ),
                    ]),
                  ),
                  body: TabBarView(
                    children: [
                      // Card(
                      //   // elevation: 50,
                      //   borderOnForeground: true,
                      //   color: Colors.orange,
                      //   shadowColor: recovaColor,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: <Widget>[
                      //       const ListTile(
                      //         leading: Icon(
                      //           Icons.person,
                      //           color: Colors.blue,
                      //           size: 30,
                      //         ),
                      //         title: Text(
                      //           "Ramiro application",
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         subtitle: Text("Ca c'est mon card",
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 16)),
                      //       ),
                      //       const Divider(
                      //         height: 16,
                      //         color: Colors.black,
                      //       ),
                      //       const ListTile(
                      //         leading: Icon(
                      //           Icons.phone_android,
                      //           color: Colors.blue,
                      //           size: 30,
                      //         ),
                      //         title: Text(
                      //           "Telephone perdu",
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         subtitle: Text("Itel A56 8GB",
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 16)),
                      //       ),
                      //       const Divider(
                      //         height: 16,
                      //         color: Colors.black,
                      //       ),
                      //       const ListTile(
                      //         leading: Icon(
                      //           Icons.email,
                      //           color: Colors.blue,
                      //           size: 30,
                      //         ),
                      //         title: Text(
                      //           "E-mail",
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 16,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         subtitle: Text("Envoyé à : Ramiro kaffo",
                      //             style: TextStyle(
                      //                 color: Colors.black, fontSize: 16)),
                      //       ),
                      //       ButtonBarTheme(
                      //           data: const ButtonBarThemeData(
                      //               alignment: MainAxisAlignment.center),
                      //           child: ButtonBar(
                      //             children: <Widget>[
                      //               FlatButton(
                      //                   onPressed: () {}, child: Text("Video")),
                      //               FlatButton(
                      //                   onPressed: () {}, child: Text("SMS"))
                      //             ],
                      //           ))
                      //     ],
                      //   ),
                      // ),
                      getListView(),
                      Card(
                          color: Colors.yellow,
                          child: Image.asset(
                            list_image_asset[1],
                            height: 200,
                            width: 200,
                          )),
                      Card(
                          color: Colors.purple,
                          child: Image.asset(
                            list_image_asset[2],
                            height: 200,
                            width: 200,
                          )),
                      Card(
                          color: Colors.green,
                          child: Image.asset(
                            list_image_asset[3],
                            height: 200,
                            width: 200,
                          )),

                    ],
                  )

                  ))),

      Center(
        child: Container(
          child: Image.asset(
            list_image_asset[1],
            width: 500,
            height: 500,
          ),
        ),
      ),
      Center(
        child: Container(
          child: Image.asset(
            list_image_asset[3],
            width: 500,
            height: 500,
          ),
        ),
      ),
      Center(
        child: Container(
          child: Image.asset(
            list_image_asset[5],
            width: 500,
            height: 500,
          ),
        ),
      ),
    ];
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 30,
        title: const Text("RECOVA"),
        leading: const Icon(Icons.menu),
        backgroundColor: recovaColor,
      ),
      bottomNavigationBar: CurvedNavigationBar(

        items: <Widget>[
          Column(
            children: const [
              Icon(
                Icons.home_filled,
                color: recovaColor,
                size: 50,
              ),
              Text("Acueil", style: TextStyle(color: recovaColor))
            ],
          ),
          Column(
            children: const [
              Icon(
                Icons.find_in_page_outlined,
                color: recovaColor,
                size: 50,
              ),
              Text("Perdu", style: TextStyle(color: recovaColor),)
            ],
          ),
          Column(
            children: const [
              Icon(
                Icons.data_saver_on_outlined,
                color: recovaColor,
                size: 50,
              ),
              Text("Retrouvé", style: TextStyle(color: recovaColor))
            ],
          ),
          Column(
            children: const [
              Icon(
                Icons.person,
                color: recovaColor,
                size: 50,
              ),
              Text("Moi", style: TextStyle(color: recovaColor))
            ],
          ),
        ],
        backgroundColor: Colors.purpleAccent,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: const Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
      body: Center(child: tab[page]),
    );
  }
}




Widget getListView() {
  var listItem = select_objects() as List;
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