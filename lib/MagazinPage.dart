import 'dart:async';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/cubit/BottomNavigationBarState.dart';
import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'package:provider/provider.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/LocalNotificationWidget.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'HomeRetrouvePage.dart';
import 'notificationservice.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/HomePerduPage.dart';




final bucketGlobal = PageStorageBucket();

class MagazinPage extends StatefulWidget {
  final String categorie;
  final String value;
  final String region;
  final int recoverCount;


  MagazinPage({
    super.key,
    required this.categorie,
    required this.value,
    required this.region,
    required this.recoverCount,
  });

  @override
  _MagazinPageState createState() => _MagazinPageState();
}

class _MagazinPageState extends State<MagazinPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  ScrollController magazinScrollController = ScrollController();
  double lastPosition = 0.0;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    magazinScrollController.addListener(() {
      if (magazinScrollController.hasClients) {
        if (lastPosition < magazinScrollController.position.pixels) {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(false);
        } else {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(true);
        }
      }
      lastPosition = magazinScrollController.position.pixels;
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = 22;
    BoxDecoration decoration = BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15));
    EdgeInsetsGeometry edgeInsetsGeometry =
    const EdgeInsets.symmetric(horizontal: 20, vertical: 0);

    Widget emptyPageWidget() {
      return errorPageWidget(
          context: context,
          onTap: () {
            showFooterActionPerdu(context);
          },
          assetImage: "images/images-2.png",
          buttonText: "Ajouter",
          message: "Aucun objet retrouvé pour le moment",
          buttonIsVisible: true,
          scale: 0.65,
          icon: Icons.add_circle);
    }

    Widget listObjectHome(String categorie, String region, {precision = "all"}) {
      // print("me voici ici : $categorie");
      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // setState(() {
              // firstPageColor = Colors.white;
              // });
              print("Il ya erreur");
              return Center(
                  child: errorPageWidget(
                      onTap: () {
                        setState(() {});
                      },
                      assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                      context: context));
            } else if (snapshot.hasData) {
              final data = snapshot.data as List;
              // print(data);
              if (data.isNotEmpty) {
                // setState(() {
                // firstPageColor = Colors.white12;
                // });
                return HomePageListElement(
                    data: data,
                    context: context,
                    state: () {
                      setState(() {});
                    },
                    scrollController: ScrollController(),
                    key: UniqueKey(),
                    categorie: categorie);
              } else {
                return Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                      child: emptyPageWidget())
                );
              }
            }
          }
          return transitionWidget2();
        },
        // initialData: initialValue,
        future: homePageGetAllObject(categorie, region, precision: precision),
      );
    }

    return PageStorage(
      bucket: bucketGlobal,
      child: DefaultTabController(
        initialIndex: widget.recoverCount != 0? 0: 1,
        length: 2,
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 30,
            backgroundColor: recovaColor,
            elevation: 2,
            leading: IconButton(
              onPressed: (){Navigator.of(context).pop();},
              icon: const Icon(Icons.arrow_back), color: Colors.white,),
            title: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                onTap: (ind) {
                },
                padding: const EdgeInsets.symmetric(horizontal: 0),
                tabs: <Widget>[
                  Tab(
                    height: height,
                    child: Container(
                      // alignment: Alignment.center,
                      // width: 110,
                      padding: edgeInsetsGeometry,
                      decoration: decoration,
                      child: const Text(
                        "Retrouvé",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Tab(
                    height: height,
                    child: Container(
                      padding: edgeInsetsGeometry,
                      decoration: decoration,
                      child: const Text(
                        "Perdu",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ]),
          ),
          key: const PageStorageKey<String>("magazin"),
          // appBar: AppBar(
          //   backgroundColor: recovaColor,
          //   leading: IconButton(
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          //   centerTitle: true,
          //   toolbarHeight: 40,
          //   actions: [
          //     IconButton(
          //         onPressed: () async {
          //           // _sendingMails();
          //           // await mailSend();
          //           Navigator.of(context).pushNamed("IconStepperDemos");
          //           return;
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => const LocalNotificationWidget(),
          //               ));
          //           // Navigator.of(context).pushNamed("soir");
          //           // _controller.reverse().then((value) => Navigator.of(context).pop());
          //         },
          //         icon: const Icon(
          //           Icons.help_outline_rounded,
          //           color: Colors.white,
          //         ))
          //   ],
          //   title: const Text(
          //     "Magazin",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          body: Scrollbar(
            controller: magazinScrollController,
            child: Container(
              color: Colors.black.withOpacity(0.05),
              child: TabBarView(
                children: () {
                  if (widget.categorie == "all") {
                    return [listObjectHome("R", "Aucune"), listObjectHome("P", "Aucune")];
                  } else if (widget.categorie == "byRegion") {
                    return [listObjectHome("R", widget.region), listObjectHome("P", widget.region)];
                  } else if (widget.categorie == "today") {
                    return [listObjectHome("R", widget.region, precision: "today"),
                      listObjectHome("P", widget.region, precision: "today")];
                  } else if (widget.categorie == "other") {
                    return [
                      buildObjectByType(context, () {
                        setState(() {});
                      },
                          selectOwnTypeObjects(
                              widget.value, "R", widget.region),
                          ScrollController(),
                          emptyPageWidget(),
                          "R"),
                      buildObjectByType(context, () {
                        setState(() {});
                      },
                          selectOwnTypeObjects(
                              widget.value, "P", widget.region),
                          ScrollController(),
                          emptyPageWidget(),
                          "P"),
                    ];
                  } else {
                    return [
                      buildObjectByType(context, () {
                        setState(() {});
                      },
                          selectOwnTypeObjects(
                              widget.value, "R", widget.region),
                          ScrollController(),
                          emptyPageWidget(),
                          "R"),
                      buildObjectByType(context, () {
                        setState(() {});
                      },
                          selectOwnTypeObjects(
                              widget.value, "P", widget.region),
                          ScrollController(),
                          emptyPageWidget(),
                          "P"),
                    ];
                  }

                }(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildObjectByType(
    BuildContext context,
    Function stateToRefresh,
    Future<List<dynamic>> future,
    ScrollController scrollController,
    Widget emptyPageWidget,
    String categorie) {
  return FutureBuilder(
    builder: (ctx, snapshots) {
      if (snapshots.connectionState == ConnectionState.done) {
        if (snapshots.hasError) {
          return Center(
              child: Center(
                  child: errorPageWidget(
                      onTap: stateToRefresh,
                      assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                      context: context)));
        } else if (snapshots.hasData) {
          final datas = snapshots.data as List;
          if (datas.isNotEmpty) {
            return HomePageListElement(
              data: datas,
              context: ctx,
              scrollController: scrollController,
              key: UniqueKey(),
              categorie: categorie,
            );
          } else {
            return Center(
              child: emptyPageWidget,
            );
          }
        }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    future: future,
  );
}

class MyTabViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabViewAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(30);

  @override
  Widget build(BuildContext context) {
    double height = 22;
    BoxDecoration decoration = BoxDecoration(
        color: recovaColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15));
    EdgeInsetsGeometry edgeInsetsGeometry =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 0);
    // TODO: implement build
    return AppBar(
      backgroundColor: Colors.white,
      excludeHeaderSemantics: true,
      elevation: 0,
      // title: Divider(
      //   color: recovaColor,
      // ),
      leading: IconButton(
        onPressed: (){Navigator.of(context).pop();},
        icon: const Icon(Icons.arrow_back_ios, color: recovaColor), color: recovaColor,),
      titleSpacing: 0,
      bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: recovaColor,
          isScrollable: true,
          onTap: (ind) {
            print(ind);
          },
          padding: const EdgeInsets.symmetric(horizontal: 0),
          tabs: <Widget>[
            Tab(
              height: height,
              child: Container(
                // alignment: Alignment.center,
                // width: 110,
                padding: edgeInsetsGeometry,
                decoration: decoration,
                child: const Text(
                  "Retrouvé",
                  style: TextStyle(color: recovaColor, fontSize: 18),
                ),
              ),
            ),
            Tab(
              height: height,
              child: Container(
                padding: edgeInsetsGeometry,
                decoration: decoration,
                child: const Text(
                  "Perdu",
                  style: TextStyle(color: recovaColor, fontSize: 18),
                ),
              ),
            ),
          ]),
    );
  }
}
