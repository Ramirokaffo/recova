import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(info),
              bottom: const TabBar(tabs: <Widget>[
                Tab(
                  child: Icon(
                    Icons.filter_vintage,
                    color: Colors.purple,
                    size: 40,
                  ),
                ),
                Tab(
                  child: Icon(Icons.phonelink_ring,
                      color: Colors.purple, size: 40),
                )
              ]),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  list_image_asset[3],
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  list_image_asset[6],
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  list_image_asset[8],
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  list_image_asset[9],
                                  height: 400,
                                  width: 400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            list_image_asset[10],
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            list_image_asset[8],
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            list_image_asset[4],
                            height: 300,
                            width: 300,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            list_image_asset[5],
                            height: 300,
                            width: 300,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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
            ),
      ),
    );
  }
}
