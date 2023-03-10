import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/cubit/BottomNavigationBarState.dart';
import 'package:projet_flutter2/main1.dart';
import 'package:projet_flutter2/recovaDrawerMenu.dart';

import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'package:projet_flutter2/recovaSearchPage.dart';
import 'package:projet_flutter2/xampple%20folder/webSocketDemo.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
// import 'package:projet_flutter2/xampple%20folder/oneSignal.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/HomePerduPage.dart';
import 'package:projet_flutter2/MagazinPage.dart';

import 'cubit/notificationIconState.dart';




class AccueilPage extends StatefulWidget {
  final GlobalKey navigatorKey;
  const AccueilPage({Key? key, required this.navigatorKey}) : super(key: key);

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> with TickerProviderStateMixin {
  // ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  // final channel = IOWebSocketChannel.connect(
  //   Uri.parse('ws://localhost:6767'),);
  final bucketGlobal = PageStorageBucket();
  ScrollController scrollController = ScrollController();
  double lastPosition = 0.0;



  Map<dynamic, dynamic> datas = {};
  bool isloading = true;
  bool isItError = false;

  // void webSocketConnect() async {
  //wss://echo.websocket.events
  //    channel.stream.listen((event) {
  //     print(event.toString());
  //   },);
  //
  // }
  bool i = true;



  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        if (lastPosition < scrollController.position.pixels) {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(false);
        } else {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(true);
        }
      }
      lastPosition = scrollController.position.pixels;
    });
    super.initState();
    if (i) {
      loadPageData();
    }
    print("Oui je m'execute");
    // newGetAllObjectType();
    // webSocketConnect();
    // channel.sink.add(
    //   jsonEncode(
    //     {
    //       "type": "subscribe",
    //       "channels": [
    //         {
    //           "name": "ticker",
    //           "product_ids": [
    //             "BTC-EUR",
    //           ]
    //         }
    //       ]
    //     },
    //   ),
    // );



    // try {
    //   // _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS);
    //   final channel = IOWebSocketChannel.connect(
    //     Uri.parse('ws://localhost:8089/message'),);
    //   // channel.
    //
    //   ///
    //   /// Démarrage de l'écoute des nouveaux messages
    //   ///
    //   channel.stream.listen((event) {
    //     print(event.toString());
    //   },);
    // } catch(e){
    //   print("Voici l'erreur: $e");
    //   ///
    //   /// Gestion des erreurs globales
    //   /// TODO
    //   ///
    // }

  }

// @override
//   void setState(VoidCallback fn) {
//     // TODO: implement setState
//     super.setState(fn);
//   }

  void loadPageData() async {
    isItError = false;
    try {
      datas = await getAllObjectType(precision: "simple");
      print("datas ${datas}");
      i = false;
      setState(() {
        isloading = false;
      });

    } catch (e) {
      setState(() {
        isloading = false;
        isItError = true;
      });
      print("Oui il ya eu erreur");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // channel.stream.listen((event) {
    //   print(event.toString());
    // },);
    // Widget emptyPageWidget() {
    //   return errorPageWidget(context: context, onTap: (){
    //     showFooterActionPerdu(context);
    //   }, assetImage: "images/images-2.png",
    //       buttonText: "Ajouter", message: "Aucun objet retrouvé pour le moment", buttonIsVisible: true,
    //       scale: 0.65, icon: Icons.add_circle);
    // }

    // Widget listObjectHome(String categorie) {
    //   return FutureBuilder(
    //     builder: (ctx, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           // setState(() {
    //           // firstPageColor = Colors.white;
    //           // });
    //           return Center(
    //               child: errorPageWidget(
    //                   onTap: () {
    //                     setState(() {});
    //                   },
    //                   assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
    //                   context: context));
    //         } else if (snapshot.hasData) {
    //           final data = snapshot.data as List;
    //           if (data.isNotEmpty) {
    //             // setState(() {
    //             // firstPageColor = Colors.white12;
    //             // });
    //             return HomePageListElement(
    //                 data: data,
    //                 context: context,
    //                 state: () {
    //                   setState(() {});
    //                 },
    //                 scrollController: scrollController,
    //                 key: UniqueKey(), categorie: categorie
    //             );
    //           } else {
    //             return Center(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children:  [
    //                   // ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
    //                   // child: Image.asset("images/images-2.png"),),
    //                   // Image.asset("images/images-2.png",
    //                   // filterQuality: FilterQuality.high,
    //                   //   fit: BoxFit.contain,
    //                   // width: MediaQuery.of(context).size.width * 2 / 3,),
    //                   emptyPageWidget()
    //                   // Text(
    //                   //   "Aucun objet retrouvé pour le moment",
    //                   //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //                   // ),
    //                 ],
    //               ),
    //             );
    //           }
    //         }
    //       }
    //       return Center(
    //         child: CircularProgressIndicator(
    //             color: recovaColor,
    //             backgroundColor: recovaColor.withOpacity(0.5),
    //             strokeWidth: 5),
    //       );
    //     },
    //     // initialData: initialValue,
    //     future: homePageGetAllObject(categorie, "Aucune"),
    //   );
    // }
  Widget isErrorWidget() {
    return Center(
        child: errorPageWidget(
            onTap: (){
              loadPageData();
            },
            assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
            context: context));
  }
    int n = 2;

    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            home: Scaffold(
                drawer: const RecoverDrawerMenu(),

                appBar: AppBar(
                  // leading: Icon(Icons.line_weight_rounded, color: recovaColor,),
                  elevation: 0,
                  centerTitle: true,
                  toolbarHeight: 35,
                  foregroundColor: recovaColor,

                  // title: StreamBuilder(
                  //   stream: channel.stream,
                  //   builder: (context, snapshot) {
                  //     print("voici snapshot: ${snapshot.data}");
                  //     return Text(snapshot.hasData ? '${snapshot.data}' : '', style: const TextStyle(fontSize: 10),);
                  //   },
                  // ),
                  // FittedBox(child: Text(pageTitle, style: const TextStyle(fontSize: 17),)),

                  backgroundColor: Colors.white,
                  // foregroundColor: Colors.white,
                  // bottom: ,
                  actions: [
                    // Text(AppLocalizations.of(context)!.helloWorld),
                    // Text(AppLocalizations.of(context)!.hello),
                    // Drawer(),
                    Stack(
                        children: [
                          IconButton(onPressed: (){
                            // channel.sink.add({"newMessage": "data"});
                            // print("Deja envoye");
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyAppSocketTest(),));
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePagees(title: "Le titre"),));
                            // return;
                            // localization.translate('en');  http://localhost:3000/api/event
                            // print(localization.getLanguageName());
                            // Navigator.of(context).pushNamed("Demo");
                            // final channel = IOWebSocketChannel.connect(
                            //   // Uri.parse('ws://localhost:3000/api/event'),
                            //   Uri.parse('ws://localhost:3000/message'),
                            // );
                            // print(channel.stream);

                            context.read<NotificationIconState>().changeNotificationCount(n);
                            ++n;
                          }, icon: const Icon(Icons.language)),
                          Positioned(
                            child: BlocBuilder<NotificationIconState, int>(builder: (BuildContext context, state) {
                              return Text("$state", style: const TextStyle(fontSize: 10),);
                            },
                            ),
                          )
                        ]
                    ),
                    Visibility(
                      visible: true,
                      child: CircleAvatar(
                        backgroundColor: Colors.white10,
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                transitionAnimationController: AnimationController(
                                    vsync: this,
                                    duration: const Duration(milliseconds: 800),
                                    animationBehavior: AnimationBehavior.preserve,
                                    reverseDuration: const Duration(milliseconds: 500)),
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder:
                                        (BuildContext context, StateSetter setState) {
                                      return DraggableScrollableSheet(
                                        maxChildSize: 0.9,
                                        initialChildSize: 0.9,
                                        minChildSize: 0.13,
                                        expand: false,
                                        builder: (BuildContext context,
                                            ScrollController scrollController) {
                                          return const RecovaSarchWidget();
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.search,
                              color: recovaColor,
                              size: 25,
                            )),
                      ),
                    ),
                    // Visibility(
                    //     child: PopupMenuButton(
                    //         elevation: 14,
                    //         initialValue: regionActuelle,
                    //         // onCanceled: () => print("Vous n'avez rien selectionné"),
                    //         onSelected: onRegionSelect,
                    //         itemBuilder: (BuildContext context) {
                    //           return (["Aucune"] + camerounRegion).map((String region) {
                    //             return PopupMenuItem<String>(
                    //               value: region,
                    //               child: Text(region),
                    //             );
                    //           }).toList();
                    //         },
                    //       // color: Colors.white10,
                    //         child: const CircleAvatar(
                    //         backgroundColor: Colors.white10,
                    //           child: Icon(Icons.sort, color: Colors.white,),
                    //         )),)
                  ],
                ),
                floatingActionButton: CircleAvatar(
                  backgroundColor: recovaColor,
                  radius: 25,
                  child: IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //     PageRouteBuilder(
                        //       opaque: false,
                        //       pageBuilder: (context, animation, secondaryAnimation) => const RecovaLostThingForm(),));
                        // showFooterActionPerdu();
                        // Navigator.of(context).push(
                        //     MyCustomPageAnimationTransition(const RecovaLostThingForm()));
                        addRecoverOrLoseObject(context);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
                key: const PageStorageKey<String>("accueil"),
                backgroundColor: Colors.black.withOpacity(0.05),
                body: Scrollbar(
                  controller: scrollController,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: isloading? transitionWidget2(): isItError? isErrorWidget(): datas.isNotEmpty? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            const Text("Objets perdus & retrouvés", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const Divider(),
                            MasonryGridView.count(
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              // primary: false,
                              shrinkWrap: true,
                              itemCount: int.parse(datas["today"][0]["countP"]) + int.parse(datas["today"][0]["countR"]) == 0 ? 1: 2 ,
                              itemBuilder: (BuildContext contex, int index){
                                if (index == 0) {
                                  return onItem(context, datas["all"][0], "all");
                                } else {
                                  return onItem(context, datas["today"][0], "today");

                                }
                              },
                              // gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            ),
                            // onItem(context, datas["all"][0], "all"),
                            const SizedBox(height: 30,),
                            const Text("Classement par catégorie", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const Divider(),
                            MasonryGridView.count(
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: datas["principal"].length ,
                              itemBuilder: (BuildContext contex, int index){
                                return onItem(context, datas["principal"][index], "principal");
                              },
                              // gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            ),
                            const SizedBox(height: 30,),
                            const Text("Classement par région", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const Divider(),
                            MasonryGridView.count(
                              controller: scrollController,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: datas["region"].length,
                              itemBuilder: (BuildContext contex, int index){
                                return onItem(context, datas["region"][index], "region");
                              },
                            ),
                            const SizedBox(height: 30,),
                            const Text("Autres catégories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const Divider(),
                            MasonryGridView.count(
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: datas["other"].length,
                              itemBuilder: (BuildContext contex, int index){
                                return onItem(context, datas["other"][index], "other");
                              },
                            ),
                            const SizedBox(height: 50,)
                          ],
                        ),
                      ): errorPageWidget(
                          context: context,
                          onTap: () {
                            showFooterActionPerdu(context);
                          },
                          assetImage: "images/images-2.png",
                          buttonText: "Ajouter",
                          message: "Aucun élément à afficher pour le moment",
                          buttonIsVisible: true,
                          scale: 0.65,
                          icon: Icons.add_circle)
                    // FutureBuilder(
                    //   builder: (ctx, snapshots) {
                    //     if (snapshots.connectionState == ConnectionState.done) {
                    //       if (snapshots.hasError) {
                    //         return Center(
                    //             child: Center(
                    //                 child: errorPageWidget(
                    //                     onTap: (){
                    //                       setState(() {});
                    //                     },
                    //                     assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                    //                     context: context)));
                    //       } else if (snapshots.hasData) {
                    //         final datas = snapshots.data as Map;
                    //         if (datas.isNotEmpty) {
                    //           print(datas["today"][0]["image"] != "None");
                    //           print(int.parse(datas["today"][0]["countP"]) + int.parse(datas["today"][0]["countR"]));
                    //           return SingleChildScrollView(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 const SizedBox(height: 20,),
                    //                 const Text("Objets perdus & retrouvés", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    //                 const Divider(),
                    //                 MasonryGridView.count(
                    //                   mainAxisSpacing: 20.0,
                    //                   crossAxisSpacing: 10,
                    //                   crossAxisCount: 2,
                    //                   // primary: false,
                    //                   shrinkWrap: true,
                    //                   itemCount: int.parse(datas["today"][0]["countP"]) + int.parse(datas["today"][0]["countR"]) == 0 ? 1: 2 ,
                    //                   itemBuilder: (BuildContext contex, int index){
                    //                     if (index == 0) {
                    //                       return onItem(context, datas["all"][0], "all");
                    //                     } else {
                    //                       return onItem(context, datas["today"][0], "today");
                    //
                    //                     }
                    //                   },
                    //                   // gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    //                 ),
                    //                 // onItem(context, datas["all"][0], "all"),
                    //                 const SizedBox(height: 30,),
                    //                 const Text("Classement par catégorie", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    //                 const Divider(),
                    //                 MasonryGridView.count(
                    //                   mainAxisSpacing: 20.0,
                    //                   crossAxisSpacing: 10,
                    //                   crossAxisCount: 2,
                    //                   primary: false,
                    //                   shrinkWrap: true,
                    //                   itemCount: datas["principal"].length ,
                    //                   itemBuilder: (BuildContext contex, int index){
                    //                     return onItem(context, datas["principal"][index], "principal");
                    //                   },
                    //                   // gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    //                 ),
                    //                 const SizedBox(height: 30,),
                    //                 const Text("Classement par région", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    //                 const Divider(),
                    //                 MasonryGridView.count(
                    //                   mainAxisSpacing: 20.0,
                    //                   crossAxisSpacing: 10,
                    //                   crossAxisCount: 2,
                    //                   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    //                   primary: false,
                    //                   shrinkWrap: true,
                    //                   itemCount: datas["region"].length,
                    //                   itemBuilder: (BuildContext contex, int index){
                    //                     return onItem(context, datas["region"][index], "region");
                    //                   },
                    //                 ),
                    //                 const SizedBox(height: 30,),
                    //                 const Text("Autres catégories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    //                 const Divider(),
                    //                 MasonryGridView.count(
                    //                   mainAxisSpacing: 20.0,
                    //                   crossAxisSpacing: 10,
                    //                   crossAxisCount: 2,
                    //                   primary: false,
                    //                   shrinkWrap: true,
                    //                   itemCount: datas["other"].length,
                    //                   itemBuilder: (BuildContext contex, int index){
                    //                     return onItem(context, datas["other"][index], "other");
                    //                   },
                    //                 ),
                    //                 const SizedBox(height: 50,)
                    //               ],
                    //             ),
                    //           );
                    //         } else {
                    //           return Center(
                    //             // child: emptyPageWidget(),
                    //             // child: emptyPageWidget,
                    //           );
                    //         }
                    //       }
                    //     }
                    //     return transitionWidget2();
                    //   },
                    //   future: getAllObjectType(precision: "simple"),
                    // ),
                  ),
                )
            ),
          );
        },);
      },
      // child:
    );
  }
}


Widget onItem2(BuildContext context ,dynamic data) {
  int count = int.parse(data["countP"]) + int.parse(data["countR"]) + 1000;
  return Column(
    children: [
      Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      child: Column(
        children: [
          Text(data["type"] ?? data["otherType"], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          Container(
            // padding: const EdgeInsets.all(5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Stack(
                    children: [
                      Image.network(data["image"]["image"]),
                      Positioned(
                        top: 1,
                        right: 1,
                        child: CircleAvatar(
                          radius: 9.0 + count.toString().length,
                          backgroundColor: recovaColor,
                          child: FittedBox(

                              child: Text("${int.parse(data["countP"]) + int.parse(data["countR"])}")),
                        ),
                      )]
                )
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            color: recovaColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5))
          ),
          child: const Text("Ouvrir", style: TextStyle(fontSize: 17,
              fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
        )
        ],
      ),
    ),

    ]
  );
}


Widget onItem(BuildContext context ,dynamic data, String rubrique) {
  // print(rubrique);

  int count = int.parse(data["countP"]) + int.parse(data["countR"]) + 1000;

  // Widget listObjectHome(String categorie, Function state) {
  //   return FutureBuilder(
  //     builder: (ctx, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.hasError) {
  //           // setState(() {
  //           // firstPageColor = Colors.white;
  //           // });
  //           return Center(
  //               child: errorPageWidget(
  //                   onTap: () {
  //                     state();
  //                   },
  //                   assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
  //                   context: context));
  //         } else if (snapshot.hasData) {
  //           final data = snapshot.data as List;
  //           if (data.isNotEmpty) {
  //             // setState(() {
  //             // firstPageColor = Colors.white12;
  //             // });
  //             return HomePageListElement(
  //                 data: data,
  //                 context: context,
  //                 state: () {
  //                   state();
  //                 },
  //                 scrollController: scrollController,
  //                 key: UniqueKey(), categorie: categorie
  //             );
  //           } else {
  //             return Center(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children:  [
  //                   // ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
  //                   // child: Image.asset("images/images-2.png"),),
  //                   // Image.asset("images/images-2.png",
  //                   // filterQuality: FilterQuality.high,
  //                   //   fit: BoxFit.contain,
  //                   // width: MediaQuery.of(context).size.width * 2 / 3,),
  //                   emptyPageWidget()
  //                   // Text(
  //                   //   "Aucun objet retrouvé pour le moment",
  //                   //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                   // ),
  //                 ],
  //               ),
  //             );
  //           }
  //         }
  //       }
  //       return Center(
  //         child: CircularProgressIndicator(
  //             color: recovaColor,
  //             backgroundColor: recovaColor.withOpacity(0.5),
  //             strokeWidth: 5),
  //       );
  //     },
  //     // initialData: initialValue,
  //     future: homePageGetAllObject(categorie, "Aucune"),
  //   );
  // }

  return Container(
    color: Colors.white,
    child: InkWell(
      child: Column(
        children: [
          Material(
            color: Colors.white,
            elevation: 3,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: [
              Text(data["type"] ?? data["otherType"], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Stack(
                        children: [
                          // Image.network(data["image"] != "None"? data["image"]["image"]: "",
                          //   loadingBuilder: (context, child, loadingProgress) {
                          //     // loadingProgress.
                          //     return SpinKitThreeBounce(
                          //       // color: recovaColor,
                          //       size: 25,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return DecoratedBox(
                          //           decoration: BoxDecoration(
                          //             color: index.isEven ? recovaColor : recovaColor,
                          //           ),
                          //         );
                          //       },
                          //     );
                          //   },
                          //   errorBuilder: (context, error, stackTrace) {
                          //     return Center(
                          //       child: Container(
                          //         padding: const EdgeInsets.symmetric(vertical: 40),
                          //         // height: 200,
                          //         child: const Text(
                          //           "Erreur lors du chargement de l'image...",
                          //           style: TextStyle(color: Colors.red),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          FadeInImage.assetNetwork(
                            placeholder: "images/Curve-Loading.gif",
                            image: data["image"] != "None"? data["image"]["image"]: "",
                            width: MediaQuery.of(context).size.width,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 40),
                                  // height: 200,
                                  child: const Text(
                                    "Erreur lors du chargement de l'image...",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [BoxShadow(spreadRadius: 5, blurRadius: 5, blurStyle: BlurStyle.outer)]
                              ),
                              child: CircleAvatar(
                                radius: 9.0 + count.toString().length,
                                backgroundColor: Colors.white,
                                child: FittedBox(
                                    child: Text("${int.parse(data["countP"]) + int.parse(data["countR"])}",
                                    style: const TextStyle(color: recovaColor),),),
                              ),
                            ),
                          )]
                    )
                ),
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                // color: recovaColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5))
              ),
              child: const Text("Voir la collection", style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.bold, color: recovaColor), textAlign: TextAlign.center,),
            )
            ],
          ),
        ),
        ]
      ),
      onTap: () async {
        switch (rubrique) {
          case "all":
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MagazinPage(categorie: "all", value: "", region: "Aucune", recoverCount: int.parse(data["countR"]),))).then((value) {
            context
                .read<BottomNavigationBarState>()
                .changeNotificationCount(true);
            // print("Ok ca va");
            });
            break;
          case "today":
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MagazinPage(categorie: "today", value: "", region: "Aucune", recoverCount: int.parse(data["countR"])))).then((value) {
              context
                  .read<BottomNavigationBarState>()
                  .changeNotificationCount(true);
            });
            break;
          case "principal":
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MagazinPage(categorie: "byCategorie", value: data["type"], region: "Aucune", recoverCount: int.parse(data["countR"])))).then((value) {
              context
                  .read<BottomNavigationBarState>()
                  .changeNotificationCount(true);
            });
            break;
          case "region":
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MagazinPage(categorie: "byRegion", value: "Tout", region: data["type"], recoverCount: int.parse(data["countR"])))).then((value) {
              context
                  .read<BottomNavigationBarState>()
                  .changeNotificationCount(true);
            });
            break;
          case "other":
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MagazinPage(categorie: "other", value: data["otherType"], region: "Aucune", recoverCount: int.parse(data["countR"])))).then((value) {
              context
                  .read<BottomNavigationBarState>()
                  .changeNotificationCount(true);
            });
        }
      },
    ),
  );
}


Widget onItem1(dynamic data) {
  return Material(
    elevation: 3,
    borderRadius: BorderRadius.circular(5),
    // color: recovaColor,
    child: Column(
      children: [
        Text(data["type"], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(data["image"]["image"])),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text("Egaré", style: TextStyle(color: recovaColor)),
                Text(data["countP"], style: const TextStyle(color: Colors.red)),
              ],
            ),
            Column(
              children: [
                const Text("Retrouvé", style: TextStyle(color: recovaColor),),
                Text(data["countR"], style: const TextStyle(color: Colors.red)),
              ],
            ),
          ],
        )
      ],
    ),
  );
}

