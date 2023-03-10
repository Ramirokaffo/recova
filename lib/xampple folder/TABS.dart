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
    "FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(info),
                  centerTitle: true,
                  backgroundColor: Colors.deepOrange,
                  actions: const <Widget>[
                    Icon(
                      Icons.accessible_forward,
                      color: Colors.black,
                    )
                  ],
                  bottom: const TabBar(tabs: <Widget>[
                    Tab(
                      child: Icon(Icons.airplane_ticket),
                    ),
                    Tab(
                      child: Icon(Icons.accessibility_new),
                    ),
                    Tab(
                      child: Icon(Icons.android),
                    ),
                    Tab(
                      child: Icon(
                        Icons.accessibility_new,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ]),
                ),
                body: TabBarView(
                  children: [
                    Card(
                      elevation: 50,
                      borderOnForeground: true,
                      color: Colors.orange,
                      shadowColor: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 30,
                            ),
                            title: Text(
                              "Ramiro application",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Ca c'est mon card",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                          const Divider(
                            height: 16,
                            color: Colors.black,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.phone_android,
                              color: Colors.blue,
                              size: 30,
                            ),
                            title: Text(
                              "Telephone perdu",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Itel A56 8GB",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                          const Divider(
                            height: 16,
                            color: Colors.black,
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 30,
                            ),
                            title: Text(
                              "E-mail",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Envoyé à : Ramiro kaffo",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                          ),
                          ButtonBarTheme(
                              data: const ButtonBarThemeData(
                                  alignment: MainAxisAlignment.center),
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                      onPressed: () {}, child: Text("Video")),
                                  FlatButton(
                                      onPressed: () {}, child: Text("SMS"))
                                ],
                              ))
                        ],
                      ),
                    ),
                    Card(
                        color: Colors.yellow,
                        child: Image.asset(
                          "/Users/user/StudioProjects/projet_flutter2/images/${list_image[1]}",
                          height: 200,
                          width: 200,
                        )),
                    Card(
                        color: Colors.purple,
                        child: Image.asset(
                          "/Users/user/StudioProjects/projet_flutter2/images/${list_image[2]}",
                          height: 200,
                          width: 200,
                        )),
                    Card(
                        color: Colors.green,
                        child: Image.asset(
                          "/Users/user/StudioProjects/projet_flutter2/images/${list_image[3]}",
                          height: 200,
                          width: 200,
                        )),
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
                )));
  }
}
