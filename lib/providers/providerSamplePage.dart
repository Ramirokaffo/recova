import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:im_stepper/main.dart';
import 'package:projet_flutter2/test_camera.dart';
import 'package:projet_flutter2/xampple%20folder/FoldingCells.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/RecovaLoginPage.dart';
import 'package:projet_flutter2/ChoiceUsersNamePage.dart';
import 'package:projet_flutter2/SaveMyDataFormPage.dart';
import 'package:projet_flutter2/xampple%20folder/SliverAppBar.dart';
import 'package:projet_flutter2/xampple%20folder/StaggeredGridViews.dart';
import 'package:projet_flutter2/UsersSettingPage.dart';
import 'package:projet_flutter2/notificationservice.dart';
import 'package:projet_flutter2/recovaSearchPage.dart';
import 'package:projet_flutter2/xampple%20folder/Steppers.dart';
import 'package:projet_flutter2/xampple folder/LanguageTestPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/UsersAccountPage.dart';
import 'package:projet_flutter2/recovaDrawerMenu.dart';
import 'package:projet_flutter2/RecovaWelcomePage.dart';
import 'package:projet_flutter2/CreateAccountFormPage.dart';
import 'package:projet_flutter2/HomePerduPage.dart';
import 'HomeRetrouvePage.dart';
import 'package:projet_flutter2/PinCodePage.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/pageStepperSample.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:projet_flutter2/xampple folder/language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_flutter2/xampple folder/localizationDemo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter2/providers/TitleState.dart';


List usersList = [];
List objectList = [];
List CNIList = [];
List VISAList = [];
List PassportList = [];
List PersonneList = [];
List DiplomeList = [];
List ActeNaissList = [];
List AutreList = [];
List PermisList = [];
List lostObjectList = [];
List recoverObjectList = [];
ScrollController scrollController = ScrollController();
final bucketGlobal = PageStorageBucket();


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TitleState())
      ],
      child: MaterialApp(
          title: 'RECOVA',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: <String, WidgetBuilder>{
            "WelcomePage": (BuildContext context) => const WelcomePage(),
            "RecovaHomePage": (BuildContext context) => const RecovaHomePage(),
            "FirstLoginPage": (BuildContext context) => const FirstLoginPage(),
            "CreateAccountPage": (BuildContext context) =>
            const CreateAccountPage(),
            "ChoiceUserNamePage": (BuildContext context) =>
            const ChoiceUserNamePage(),
            "IconStepperDemos": (BuildContext context) => IconStepperDemos(),
            "RecovaSarchWidget": (BuildContext context) =>
            const RecovaSarchWidget(),
            "UserSettingPage": (BuildContext context) =>
                UserSettingPage(key: UniqueKey()),
            "SilverAppBar": (BuildContext context) => SilverAppbarXample(),
            "SatagarredGridViews": (BuildContext context) =>
                SatagarredGridViews(),
            "FoldingCells": (BuildContext context) => FoldingCells(),
            "HomePage": (BuildContext context) => HomePage(),
            "Demo": (BuildContext context) => Demo(),
            "StepperSample": (BuildContext context) => IconStepperDemos()
          },
          // supportedLocales: localization.supportedLocales,
          // localizationsDelegates: localization.localizationsDelegates,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English, no country code
            Locale('fr', ''),
          ],
          locale: Locale("en", ""),
          home: const WelcomePage()),
    );
  }
}

class RecovaHomePage extends StatefulWidget {
  const RecovaHomePage({Key? key, BuildContext? context}) : super(key: key);

  @override
  _RecovaHomePageState createState() => _RecovaHomePageState();
}

class _RecovaHomePageState extends State<RecovaHomePage>
    with TickerProviderStateMixin {
  // final FlutterLocalization localization = FlutterLocalization.instance;

  int bpage = 0;
  String pageTitle = "Tout";
  bool searchIsVisible = true;
  bool objectTypeIsVisible = true;
  Color firstPageColor = Colors.black12;

  PageController page = PageController();

  PageController pageController = PageController();
  TitleHomePage titleHomePage = TitleHomePage(title: "Tout",);
  String regionActuelle = "Aucune";



  @override
  void initState() {
    // TODO: implement initState
    // localization.init(
    //   mapLocales: [
    //     const MapLocale('en', AppLocale.EN),
    //     const MapLocale('km', AppLocale.KM),
    //     const MapLocale('ja', AppLocale.JA),
    //   ],
    //   initLanguageCode: 'en',
    // );
    // localization.onTranslatedLanguage = _onTranslatedLanguage;
    // super.initState();
    super.initState();

    getOneUserDataById();
  }

  /// the setState function here is a must to add
  // void _onTranslatedLanguage(Locale? locale) {
  //   setState(() {});
  // }

  void show(BuildContext context, Widget Function(BuildContext) build) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: build);

    overlayState?.insert(overlayEntry);

    await Future.delayed(const Duration(seconds: 5));

    overlayEntry.remove();
  }


  void onRegionSelect(String region) {
    setState(() {
      pageTitle = pageTitle.split("~").toList()[0] + (region == "Aucune"? "": "~$region");
      regionActuelle = region;
    });
  }

  void updateTitle(String newObjectType) {
    if (pageTitle.contains("~")) {
      pageTitle = "${newObjectType == "Aucune"? "": newObjectType}~${pageTitle.split("~").toList().last}";
    } else {
      pageTitle = newObjectType;
    }

  }

  @override
  Widget build(BuildContext context) {
    TitleState titleState = Provider.of<TitleState>(context, listen: false);

    State state = titleHomePage.createState();
    state.activate();
    var statefulElement = titleHomePage.createElement();


    Widget emptyPageWidget() {
      return errorPageWidget(context: context, onTap: (){
        showFooterActionPerdu(context);
      }, assetImage: "images/images-2.png",
          buttonText: "Ajouter", message: "Aucun objet retrouvé pour le moment", buttonIsVisible: true,
          scale: 0.65, icon: Icons.add_circle);
    }


    Widget listeObjecTypeSide() {
      const Color color  = recovaColor;
      const Color textColor = Colors.black;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(0);
                // updateTitle("Tout");
                titleState.changeTitle("Tout");
                // pageTitle = "Tout";
                // setState(() {});
              }, icon: const Icon(
                Icons.all_inclusive,
                color: color,
              ),),
              const Text("Tout", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(1);
                // updateTitle("CNI");
                titleState.changeTitle("CNI");


                // pageTitle = "CNI";
                // setState(() {});

              }, icon: const Icon(
                Icons.receipt,
                color: color,
              ),),
              const Text("CNI", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(2);
                // updateTitle("Passport");
                titleState.changeTitle("Passport");

                // pageTitle = "Passport";
                // setState(() {});

              }, icon: const Icon(
                Icons.book,
                color: color,
              ),),
              const Text("Passport", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(3);
                // updateTitle("Permis de conduite");
                titleState.changeTitle("Permis de conduite");

                // pageTitle = "Permis de conduite";
                // setState(() {});

              }, icon: const Icon(
                Icons.book_outlined,
                color: color,
              ),),
              const Text("Permis de conduite", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(4);
                // updateTitle("Enfant");
                titleState.changeTitle("Enfant");

                // pageTitle = "Enfant";
                // setState(() {});

              }, icon: const Icon(
                Icons.person_outline,
                color: color,
              ),),
              const Text("Enfant", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(5);
                // updateTitle("Diplôme");
                titleState.changeTitle("Diplôme");

                // pageTitle = "Diplôme";
                // setState(() {});

              }, icon: const Icon(
                Icons.school_outlined,
                color: color,
              ),),
              const Text("Diplôme", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(6);
                // updateTitle("Acte de naissance");
                titleState.changeTitle("Acte de naissance");

                // pageTitle = "Acte de naissance";
                // setState(() {});
              }, icon: const Icon(
                Icons.contact_page_outlined,
                color: color,
              ),),
              const Text("Acte de naissance", style: TextStyle(color: textColor),)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: () {
                page.jumpToPage(7);
                // updateTitle("Autres");
                titleState.changeTitle("Autres");

                // pageTitle = "Autres";
                // setState(() {});
              }, icon: const Icon(
                Icons.more_horiz,
                color: color,
              ),),
              const Text("Autres", style: TextStyle(color: textColor),)
            ],
          ),
        ],
      );
    }

    // List<SideMenuItem> items = [
    //   SideMenuItem(
    //     priority: 0,
    //     title: 'Tout',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Tout";
    //       });
    //       page.jumpToPage(0);
    //     },
    //     icon: const Icon(
    //       Icons.all_inclusive,
    //       color: recovaColor,
    //     ),
    //   ),
    //   SideMenuItem(
    //     priority: 1,
    //     title: 'CNI',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "CNI";
    //       });
    //       page.jumpToPage(1);
    //     },
    //     icon: const Icon(Icons.receipt),
    //   ),
    //   SideMenuItem(
    //     priority: 2,
    //     title: 'Passport',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Passport";
    //       });
    //       page.jumpToPage(2);
    //     },
    //     icon: const Icon(Icons.book),
    //   ),
    //   SideMenuItem(
    //     priority: 3,
    //     title: 'Permis de conduite',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Permis de conduite";
    //       });
    //       page.jumpToPage(3);
    //     },
    //     icon: const Icon(Icons.book_outlined),
    //   ),
    //   SideMenuItem(
    //     priority: 4,
    //     title: 'Enfant',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Enfant";
    //       });
    //       page.jumpToPage(4);
    //     },
    //     icon: const Icon(Icons.person_outline),
    //   ),
    //   SideMenuItem(
    //     priority: 5,
    //     title: 'Diplôme',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Diplôme";
    //       });
    //       page.jumpToPage(5);
    //     },
    //     icon: Icon(Icons.school_outlined),
    //   ),
    //   SideMenuItem(
    //     priority: 6,
    //     title: 'Acte de naissance',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Acte de naissance";
    //       });
    //       page.jumpToPage(6);
    //     },
    //     icon: const Icon(Icons.contact_page_outlined),
    //   ),
    //   SideMenuItem(
    //     priority: 7,
    //     title: 'Autres',
    //     onTap: () {
    //       setState(() {
    //         pageTitle = "Autres";
    //       });
    //       page.jumpToPage(7);
    //     },
    //     icon: const Icon(
    //       Icons.more_horiz,
    //       color: Colors.white,
    //     ),
    //   ),
    // ];

    Widget listObjectHome(String categorie) {
      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // setState(() {
              firstPageColor = Colors.white;
              // });
              return Center(
                  child: errorPageWidget(
                      onTap: () {
                        setState(() {});
                      },
                      assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                      context: context));
            } else if (snapshot.hasData) {
              final data = snapshot.data as List;
              if (data.isNotEmpty) {
                // setState(() {
                firstPageColor = Colors.white12;
                // });
                return HomePageListElement(
                    data: data,
                    context: context,
                    state: () {
                      setState(() {});
                    },
                    scrollController: scrollController,
                    key: UniqueKey(), categorie: categorie
                );
              } else {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      // ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                      // child: Image.asset("images/images-2.png"),),
                      // Image.asset("images/images-2.png",
                      // filterQuality: FilterQuality.high,
                      //   fit: BoxFit.contain,
                      // width: MediaQuery.of(context).size.width * 2 / 3,),
                      emptyPageWidget()
                      // Text(
                      //   "Aucun objet retrouvé pour le moment",
                      //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      // ),
                    ],
                  ),
                );
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(
                color: recovaColor,
                backgroundColor: recovaColor.withOpacity(0.5),
                strokeWidth: 5),
          );
        },
        // initialData: initialValue,
        future: homePageGetAllObject(categorie, regionActuelle),
      );
    }

    Widget mySideMenu(BuildContext context) {
      return Positioned(
        top: 100,
        left: 0,
        child: Material(
            color: Colors.transparent,
            child: listeObjecTypeSide()
          // SideMenu(
          //   controller: page,
          //   // title: SizedBox(height: 50,),
          //   footer: const Text('RECOVA'),
          //   // Notify when display mode changed
          //   onDisplayModeChanged: (mode) {
          //     print(mode);
          //   },
          //   // List of SideMenuItem to show them on SideMenu
          //   items: items,
          //   style: SideMenuStyle(
          //       displayMode: SideMenuDisplayMode.auto,
          //       openSideMenuWidth: 100,
          //       compactSideMenuWidth: 40,
          //       hoverColor: Colors.blue[100],
          //       selectedColor: recovaColor.withOpacity(0.3),
          //       selectedIconColor: recovaColor,
          //       unselectedIconColor: recovaColor,
          //       backgroundColor: Colors.transparent,
          //       selectedTitleTextStyle:
          //       const TextStyle(color: Colors.white),
          //       unselectedTitleTextStyle:
          //       const TextStyle(color: Colors.black54),
          //       iconSize: 20,
          //       itemBorderRadius: const BorderRadius.all(
          //         Radius.circular(5.0),
          //       ),
          //       showTooltip: true,
          //       itemHeight: 50.0,
          //       itemInnerSpacing: 8.0,
          //       itemOuterPadding:
          //       const EdgeInsets.symmetric(horizontal: 0.0),
          //       toggleColor: Colors.black54),
          // ),
        ),
      );
    }

    var tab = <Widget>[
      DefaultTabController(
        length: 2,
        child: Scaffold(
          // persistentFooterButtons: [Icon(Icons.accessibility_new), Icon(Icons.offline_pin)],
          // endDrawer: Icon(Icons.add_circle),
          // bottomSheet: Icon(Icons.add_box),
          // bottomSheet: Divider(height: 1, color: Colors.red,),
          // backgroundColor: firstPageColor,
          // floatingActionButton: Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     InkWell(
          //       child: Icon(
          //         Icons.keyboard_double_arrow_up,
          //         color: Colors.black.withOpacity(0.5),
          //       ),
          //       onTap: () {
          //         if (scrollController.hasClients) {
          //           double a = scrollController.position.pixels;
          //           double c = 3000;
          //           if (a < 3000) {
          //             c = 0;
          //           }
          //           Timer(const Duration(milliseconds: 10), () {
          //             scrollController.position.animateTo(c,
          //                 duration: const Duration(seconds: 1),
          //                 curve: Curves.ease);
          //           });
          //         }
          //       },
          //       onLongPress: () {
          //         if (scrollController.hasClients) {
          //           Timer(const Duration(milliseconds: 100), () {
          //             scrollController.position.jumpTo(
          //                 scrollController.position.minScrollExtent);
          //           });
          //         }
          //       },
          //     ),
          //     InkWell(
          //       child: Icon(
          //         Icons.keyboard_double_arrow_down,
          //         color: Colors.black.withOpacity(0.5),
          //       ),
          //       onTap: () {
          //         if (scrollController.hasClients) {
          //           double a = scrollController.position.pixels;
          //           double b = scrollController.position.maxScrollExtent;
          //           double c = 3000;
          //           if ((b - a) < 3000) {
          //             c = (b - a);
          //           }
          //           Timer(const Duration(milliseconds: 10), () {
          //             scrollController.position.animateTo(a + c,
          //                 duration: const Duration(seconds: 1),
          //                 curve: Curves.ease);
          //           });
          //         }
          //       },
          //       onLongPress: () {
          //         double a = scrollController.position.pixels;
          //         double b = scrollController.position.maxScrollExtent;
          //         double c = 30000;
          //         if ((b - a) < 30000) {
          //           c = (b - a);
          //         }
          //         if (scrollController.hasClients) {
          //           Timer(const Duration(milliseconds: 100), () {
          //             scrollController.position.jumpTo(c);
          //           });
          //         }
          //       },
          //     ),
          //   ],
          // ),
          // appBar: const MyTabViewAppBar(),
          body: Stack(children: [
            Row(
              children: [
                Visibility(
                    visible: !objectTypeIsVisible,
                    child: mySideMenu(context)
                ),
                Expanded(
                  child: Scaffold(
                    appBar: const MyTabViewAppBar(),
                    body: PageView(
                      controller: page,
                      children: [
                        TabBarView(children: [
                          listObjectHome("R"),
                          listObjectHome("P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("CNI", CNIList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("CNI", CNIList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                          // Text("Objet perduit"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Passport", PassportList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Passport", PassportList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Permis de conduire", PermisList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Permis de conduire", PermisList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("Enfant", PersonneList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("Enfant", PersonneList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("Diplôme", DiplomeList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});
                          }, selectOwnTypeObjects("Diplôme", DiplomeList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Acte de naissance", ActeNaissList, "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Acte de naissance", ActeNaissList, "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                        TabBarView(children: [
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Autres",
                                  AutreList,
                                  "R", regionActuelle),
                              ScrollController(), emptyPageWidget(), "R"),
                          buildObjectByType(context, () {
                            setState(() {});},
                              selectOwnTypeObjects(
                                  "Autres",
                                  AutreList,
                                  "P", regionActuelle),
                              ScrollController(), emptyPageWidget(), "P"),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: objectTypeIsVisible,
              child: Positioned(
                left: 0,
                bottom: MediaQuery.of(context).size.height / 2,
                child: IconButton(
                    onPressed: () {
                      show(context, mySideMenu);
                      // setState(() {
                      //   objectTypeIsVisible = !objectTypeIsVisible;
                      // });
                    },
                    icon: const Icon(Icons.more_vert_outlined)),
              ),
            ),
          ]),
        ),
      ),
      const HomePerduPage(),
      const HomeRetrouvePage(),
      const UserAccountPage(),
    ];

    return PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 35,
          title: Consumer<TitleState>(
              builder: (context, titleState, child) {

                return FittedBox(child: Text(titleState.pageTitle, style: const TextStyle(fontSize: 17),));
              }),

          backgroundColor: recovaColor,
          foregroundColor: Colors.white,
          // bottom: ,
          actions: [
            // Text(AppLocalizations.of(context)!.helloWorld),
            // Text(AppLocalizations.of(context)!.hello),
            // Drawer(),
            IconButton(onPressed: (){
              // localization.translate('en');
              // print(localization.getLanguageName());
              Navigator.of(context).pushNamed("Demo");
            }, icon: Icon(Icons.language)),
            Visibility(
              visible: searchIsVisible,
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
                      color: Colors.white,
                      size: 25,
                    )),
              ),
            ),
            Visibility(
              child: PopupMenuButton(
                  elevation: 14,
                  initialValue: regionActuelle,
                  // onCanceled: () => print("Vous n'avez rien selectionné"),
                  onSelected: onRegionSelect,
                  itemBuilder: (BuildContext context) {
                    return (["Aucune"] + camerounRegion).map((String region) {
                      return PopupMenuItem<String>(
                        value: region,
                        child: Text(region),
                      );
                    }).toList();
                  },
                  // color: Colors.white10,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(Icons.sort, color: Colors.white,),
                  )),)
          ],
        ),
        drawer: const RecoverDrawerMenu(),
        drawerScrimColor: recovaColor,

        bottomNavigationBar:

        // ResponsiveNavigationBar(
        //   backgroundBlur: 1,
        //   backgroundOpacity: 0.5,
        //   backgroundColor: Colors.white,
        //   selectedIndex: page,
        //   activeIconColor: Colors.white,
        //   inactiveIconColor: recovaColor,
        //   // backgroundGradient: LinearGradient(
        //   //   colors: <Color>[
        //   //     recovaColor,
        //   //     Colors.transparent,
        //   //     recovaColor.withOpacity(0.5),
        //   //   ],
        //   // ),
        //   onTabChange: (index) {
        // setState(() {
        //   page = index;});},
        //   // showActiveButtonText: false,
        //   textStyle: const TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   navigationBarButtons: const <NavigationBarButton>[
        //     NavigationBarButton(
        //       textColor: Colors.white,
        //       backgroundColor: recovaColor,
        //       text: 'Accueil',
        //       icon: Icons.home_filled,
        //       // backgroundGradient: LinearGradient(
        //       //   colors: <Color>[
        //       //     recovaColor,
        //       //     Colors.transparent,
        //       //     recovaColor.withOpacity(0.5),
        //       //   ],
        //       // ),
        //     ),
        //     NavigationBarButton(
        //       text: 'Perdu',
        //       icon: Icons.sick_outlined,
        //       backgroundColor: recovaColor,
        //       // backgroundGradient: LinearGradient(
        //       //   colors: <Color>[Colors.cyan, Colors.teal],
        //       // ),
        //     ),
        //     NavigationBarButton(
        //       text: 'Retrouvé',
        //       icon: Icons.manage_search_sharp,
        //       backgroundColor: recovaColor,
        //       // backgroundGradient: LinearGradient(
        //       //   colors: <Color>[Colors.green, Colors.yellow],
        //       // ),
        //     ),
        //     NavigationBarButton(
        //       text: 'Paramètre',
        //       icon: Icons.settings,
        //       backgroundColor: recovaColor,
        //       // backgroundGradient: LinearGradient(
        //       //   colors: <Color>[Colors.green, Colors.yellow],
        //       // ),
        //     ),
        //   ],
        // ),

        CurvedNavigationBar(
          color: recovaColor,
          height: 50,
          items: <Widget>[
            Column(
              children: const [
                Icon(
                  Icons.home_filled,
                  color: Colors.white,
                  size: 30,
                ),
                Text("Acueil", style: TextStyle(color: Colors.white))
              ],
            ),
            Column(
              children: const [
                Icon(
                  Icons.find_in_page_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  "Perdu",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Column(
              children: const [
                Icon(
                  Icons.data_saver_on_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Text("Retrouvé", style: TextStyle(color: Colors.white))
              ],
            ),
            Column(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
                Text("Mon compte", style: TextStyle(color: Colors.white))
              ],
            ),
          ],
          backgroundColor: Colors.white12,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: const Duration(milliseconds: 1000),
          onTap: (index) {
            pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);

            // setState(() {
            //
            //   bpage = index;
            //   switch (bpage) {
            //     case 0:
            //       pageTitle = "RECOVA";
            //       searchIsVisible = true;
            //       break;
            //     case 1:
            //       pageTitle = "--";
            //       searchIsVisible = true;
            //       break;
            //     case 2:
            //       pageTitle = "--";
            //       searchIsVisible = true;
            //       break;
            //     case 3:
            //       pageTitle = "Mon compte";
            //       searchIsVisible = false;
            //   }
            // });
          },
        ),
        body: SafeArea(
          bottom: false,
          child: PageView(
              controller: pageController,
              children: [
                Center(child: tab[0]),
                Center(child: tab[1]),
                Center(child: tab[2]),
                Center(child: tab[3]),
              ]),
        ),
      ),
    );
  }
}





Widget errorPageWidget(
    {required BuildContext context,
      required Function onTap,
      required String assetImage,
      String message = "Une erreur s'est produite lors du chargement de la page",
      String buttonText = "Rafraîchir",
      IconData icon = Icons.refresh,
      double scale = 2,
      bool buttonIsVisible = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        assetImage,
        fit: BoxFit.fitWidth,
        scale: scale,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        message,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      Visibility(
        visible: buttonIsVisible,
        child: Container(
          height: 40,
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 2 / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: recovaColor,
              )),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: recovaColor),
                Text(
                  buttonText,
                  style: const TextStyle(
                      color: recovaColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


Widget emptyPageWidget(
    {required BuildContext context,
      required Function onTap,
      required String assetImage,
      String message = "Une erreur s'est produite lors du chargement de la page",
      String buttonText = "Rafraîchir",
      IconData icon = Icons.refresh,
      double scale = 2,
      bool buttonIsVisible = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        assetImage,
        fit: BoxFit.fitWidth,
        scale: scale,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        message,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      Visibility(
        visible: buttonIsVisible,
        child: Container(
          height: 40,
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 2 / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: recovaColor,
              )),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: recovaColor),
                Text(
                  buttonText,
                  style: const TextStyle(
                      color: recovaColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}




Widget buildObjectByType(BuildContext context, Function stateToRefresh,
    Future<List<dynamic>> future, ScrollController scrollController, Widget emptyPageWidget,
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
              key: UniqueKey(), categorie: categorie,
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
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "CNI",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "VISA",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Passport",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Permis de conduire",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Enfants égarés",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Diplômes",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Actes de naissance",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Tab(
            //   height: height,
            //   child: Container(
            //     decoration: decoration,
            //     padding: edgeInsetsGeometry,
            //     child: const Text(
            //       "Autres",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
          ]),
    );
  }
}




class TitleHomePage extends StatefulWidget {
  String title;
  TitleHomePage({Key? key, BuildContext? context, required this.title}) : super(key: key);

  @override
  _TitleHomePage createState() => _TitleHomePage();
}



class _TitleHomePage extends State<TitleHomePage>{

  @override
  void initState() {

    super.initState();

  }
  void stateSet(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Text(widget.title);
  }


}