import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:im_stepper/main.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/RealNotificationService.dart';
import 'package:projet_flutter2/cubit/notificationIconState.dart';
import 'package:projet_flutter2/cubit/BottomNavigationBarState.dart';
import 'package:projet_flutter2/cubit/NetWorkImageState.dart';
import 'package:projet_flutter2/socket_service.dart';
import 'package:projet_flutter2/test_camera.dart';
import 'package:projet_flutter2/userTransactionPage.dart';
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
import 'package:web_socket_channel/io.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/UsersAccountPage.dart';
import 'package:projet_flutter2/recovaDrawerMenu.dart';
import 'package:projet_flutter2/RecovaWelcomePage.dart';
import 'package:projet_flutter2/CreateAccountFormPage.dart';
import 'package:projet_flutter2/HomePerduPage.dart';
import 'HomeRetrouvePage.dart';
// import 'package:projet_flutter2/PinCodePage.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/pageStepperSample.dart';
import 'package:projet_flutter2/AccueilPage.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
// import 'package:projet_flutter2/RoutesFile.dart';
// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:projet_flutter2/xampple folder/language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_flutter2/xampple folder/localizationDemo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:projet_flutter2/providers/TitleState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// await Firebase.initializeApp(
// options: DefaultFirebaseOptions.currentPlatform,
// );

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
final bucketGlobal = PageStorageBucket();
RealNotificationService realNotificationService = RealNotificationService();


//st ctrl + espace
// projetFlutter2

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  Workmanager().initialize(

    // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true
  );
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: Duration(seconds: 2),
  );
  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Je suis en train d'executer une fonction en arriere plan");
    print("Je suis en train d'executer une fonction en arriere plan");
    print("Je suis en train d'executer une fonction en arriere plan");
    subscribeUserToNotification();
    // // initialise the plugin of flutterlocalnotifications.
    // FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
    //
    // // app_icon needs to be a added as a drawable
    // // resource to the Android head project.
    // var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var IOS = new IOSInitializationSettings();
    /*
    	<key>UIBackgroundModes</key>
    <array>
    	<string>processing</string>
    </array>
    <key>BGTaskSchedulerPermittedIdentifiers</key>
    	<array>
    		<string>task-identifier</string>
      </array>
     */
    //
    // // initialise settings for both Android and iOS device.
    // var settings = new InitializationSettings(android, IOS);
    // flip.initialize(settings);
    // _showNotificationWithDefaultSound(flip);
    return Future.value(true);

  });
}

// Future _showNotificationWithDefaultSound(flip) async {
//
//   // Show a notification after every 15 minute with the first
//   // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description',
//       importance: Importance.Max,
//       priority: Priority.High
//   );
//   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//
//   // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics = new NotificationDetails(
//       androidPlatformChannelSpecifics,
//       iOSPlatformChannelSpecifics
//   );
//   await flip.show(0, 'GeeksforGeeks',
//       'Your are one step away to connect with GeeksforGeeks',
//       platformChannelSpecifics, payload: 'Default_Sound'
//   );
// }


Future subscribeUserToNotification() async {
  if (await localBdSelectSetting("account") == "yes") {
    realNotificationService.initialize();
    String? id = await getId();
    print("voici d'id: $id");
    print("${await localBdSelectSetting("token")}");
    print(oneUserDataDico);
    if (oneUserDataDico.isEmpty) {
      // pendingPageFunction(context);
      await getOneUserDataById();
      // Navigator.of(context).pop();
      // showFooterUserAccountInfo(context);
    }

    SocketService.connectAndListenToSocket(await localBdSelectSetting("token"), id!, oneUserDataDico["id"]);
    SocketService.socket!.onAny((event, data) {
      // setState(() {});
      realNotificationService.showOnGoingNotification(id: 1, title: data["data"]["title"], body: data["data"].toString());
      try{
        // realNotificationService.showOnGoingNotification(flutterLocalNotificationsPlugin, id: data["data"]["id"]?? data["data"].hashCode, title: data["categorie"], body: data["data"]);
      } catch (e) {
        print("L'erreur des notifications: $e",);
      }
      print(data["data"]);
      print(event);
      // context.read<NotificationIconState>().changeNotificationCount(data);

    });
  }
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotificationIconState(2)),
        BlocProvider(create: (context) => BottomNavigationBarState(true)),
        BlocProvider(create: (context) => NetWorkImageState("")),

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
            // "ChoiceUserNamePage": (BuildContext context) =>
            //     const ChoiceUserNamePage(),
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
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('fr', ''),
          ],
          locale: Locale("en", ""),
          // home: const AccueilPage(navigatorKey: GlobalObjectKey(""))),
          home: const WelcomePage()),
    );
  }
}



class RecovaHomePage extends StatefulWidget {
  final Function? pendingFunction;
  const RecovaHomePage({Key? key, BuildContext? context, this.pendingFunction}) : super(key: key);

  @override
  _RecovaHomePageState createState() => _RecovaHomePageState();
}

class _RecovaHomePageState extends State<RecovaHomePage>
    with TickerProviderStateMixin {
  // final FlutterLocalization localization = FlutterLocalization.instance;
  final bucketGlobal = PageStorageBucket();
  String indicator = "";

  int bpage = 0;
  String pageTitle = "Tout";
  bool searchIsVisible = true;
  bool objectTypeIsVisible = true;
  Color firstPageColor = Colors.black12;

  PageController page = PageController();

  PageController pageController = PageController();
  TitleHomePage titleHomePage = TitleHomePage(title: "Tout",);
  int currentPage = 0;
  double lastPosition = 0.0;

  late List<Widget> tab;
  late int _selectedPage;

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Accueil",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.swap_vert),
      label: "Transactions",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Moi",
    )
  ];






  Future pendingFunctionExe() async {
  bool status = await widget.pendingFunction!();
  if (status) {
    setState(() {
      indicator = "";
    });
  } else {
    Navigator.of(context).pop();
  }
}


Future subscribeUserToNotification() async {
    if (SocketService.socket!.connected) return;
    if (await localBdSelectSetting("account") == "yes") {
      realNotificationService.initialize();
      String? id = await getId();
    print("voici d'id: $id");
    print("${await localBdSelectSetting("token")}");
    print(oneUserDataDico);
    if (oneUserDataDico.isEmpty) {
      // pendingPageFunction(context);
      await getOneUserDataById();
      // Navigator.of(context).pop();
      // showFooterUserAccountInfo(context);
    }


    SocketService.connectAndListenToSocket(await localBdSelectSetting("token"), id!, oneUserDataDico["id"]);
    SocketService.socket!.onAny((event, data) {
      // setState(() {});
      realNotificationService.showOnGoingNotification(id: 1, title: data["data"]["title"], body: data["data"].toString());
    try{
      // realNotificationService.showOnGoingNotification(flutterLocalNotificationsPlugin, id: data["data"]["id"]?? data["data"].hashCode, title: data["categorie"], body: data["data"]);
    } catch (e) {
      print("L'erreur des notifications: $e",);
    }
      print(data["data"]);
      print(event);
      // context.read<NotificationIconState>().changeNotificationCount(data);

    });
    }
  }

  void listenToNotification() => realNotificationService.onNotificationClick.stream.listen((event) {
    if (event!.isNotEmpty)  {
      print("Payload: $event");
    }
  });

  @override
  void initState() {
    // TODO: implement initState

    if (widget.pendingFunction != null) {
      indicator = "pending";
      pendingFunctionExe();
    }
    subscribeUserToNotification();
    listenToNotification();
    tab = [
      AccueilPage(key: const PageStorageKey<String>("Accueil"), navigatorKey: MyKeys.getKeys().elementAt(0)),
  const SizedBox(),
      const SizedBox()
    ];
    _selectedPage = 0;


    // print(fcmToken);
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

    // getOneUserDataById();
  }
  // final channel = IOWebSocketChannel.connect(
  //   Uri.parse('ws://localhost:3000/api/event'),
  // );

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

  final List<NavigationBarButton> _itemResponsive = [
    const NavigationBarButton(
      textColor: Colors.white,
      backgroundColor: recovaColor,
      text: 'Accueil',
      icon: Icons.home_filled,

    ),
    const NavigationBarButton(
      text: 'Transaction',
      icon: Icons.swap_vert,
      backgroundColor: recovaColor,

    ),
    const NavigationBarButton(
      text: 'Paramètre',
      icon: Icons.settings,
      backgroundColor: recovaColor,

    ),
  ];

  // void onRegionSelect(String region) {
  //   setState(() {
  //     pageTitle = pageTitle.split("~").toList()[0] + (region == "Aucune"? "": "~$region");
  //     regionActuelle = region;
  //   });
  // }

  // void updateTitle(String newObjectType) {
  //   if (pageTitle.contains("~")) {
  //     pageTitle = "${newObjectType == "Aucune"? "": newObjectType}~${pageTitle.split("~").toList().last}";
  //   } else {
  //     pageTitle = newObjectType;
  //   }
  //
  // }



  @override
  Widget build(BuildContext context) {
    List<Color> gradiant = [recovaColor.withBlue(250), recovaColor, recovaColor.withBlue(250)];
    late int exPosition;


    State state = titleHomePage.createState();
    state.activate();
    var statefulElement = titleHomePage.createElement();

    Widget principalPage() {
      return PageStorage(
        bucket: bucketGlobal,
        key: const PageStorageKey<String>("pa"),
        child: Scaffold(
          backgroundColor: Colors.white,
          key: const PageStorageKey<String>("bf"),
          extendBodyBehindAppBar: true,
          drawerScrimColor: recovaColor,
          bottomNavigationBar:
          // BlocBuilder<BottomNavigationBarState, bool>(builder: (BuildContext context, state) {
          //   return Visibility(
          //   visible: state,
          //     child: Container(
          //       decoration: const BoxDecoration(
          //       color: recovaColor,
          //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          //       ),
          //       child: BottomNavigationBar(
          //         backgroundColor: Colors.transparent,
          //         selectedItemColor: recovaColor,
          //         unselectedItemColor: Colors.black,
          //         elevation: 15,
          //         selectedFontSize: 17,
          //         showUnselectedLabels: false,
          //         // type: BottomNavigationBarType.shifting,
          //         selectedLabelStyle: const TextStyle(color: Colors.black),
          //         items: _items,
          //         currentIndex: _selectedPage,
          //         onTap: (index) {
          //           setState(() {
          //             if (tab[index] is SizedBox) {
          //               if (index == 1) {
          //                 tab[index] = const UserTransactionPage();
          //               } else {
          //                 tab[index] = const UserAccountPage(key: PageStorageKey<String>("UserAccountPage"));
          //               }
          //             }
          //             _selectedPage = index;
          //           });
          //         },
          //       ),
          //     ),
          //   );
          // },
          // ),


      BlocBuilder<BottomNavigationBarState, bool>(builder: (BuildContext context, state) {
        return Container(
            color: recovaColor,

            child: Visibility(
              visible: state,
              child: ResponsiveNavigationBar(
                backgroundBlur: 0.5,
                backgroundOpacity: 0.5,
                backgroundColor: Colors.white,
                selectedIndex: _selectedPage,
                activeIconColor: Colors.white,
                inactiveIconColor: Colors.black,
                onTabChange: (index) {
                  setState(() {
                    if (tab[index] is SizedBox) {
                      if (index == 1) {
                        tab[index] = const UserTransactionPage();
                      } else {
                        tab[index] = const UserAccountPage(
                            key: PageStorageKey<String>("UserAccountPage"));
                      }
                    }
                    _selectedPage = index;
                  });
                  // setState(() {
                  //   currentPage = index;
                  // });
                  // pageController.animateToPage(
                  //     index, duration: const Duration(milliseconds: 100),
                  //     curve: Curves.bounceIn);

                },
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                navigationBarButtons: _itemResponsive,
              ),
            ),
          );}),
/*



 */
          //     CurvedNavigationBar(
          //   color: recovaColor,
          //   height: 50,
          //   items: <Widget>[
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.home_filled,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Acueil", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.find_in_page_outlined,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text(
          //           "Perdu",
          //           style: TextStyle(color: Colors.white),
          //         )
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.data_saver_on_outlined,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Retrouvé", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Mon compte", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //   ],
          //   backgroundColor: Colors.white12,
          //   animationCurve: Curves.fastLinearToSlowEaseIn,
          //   animationDuration: const Duration(milliseconds: 1000),
          //   onTap: (index) {
          //     pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
          //
          //     // setState(() {
          //     //
          //     //   bpage = index;
          //     //   switch (bpage) {
          //     //     case 0:
          //     //       pageTitle = "RECOVA";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 1:
          //     //       pageTitle = "--";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 2:
          //     //       pageTitle = "--";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 3:
          //     //       pageTitle = "Mon compte";
          //     //       searchIsVisible = false;
          //     //   }
          //     // });
          //   },
          // ),
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: WillPopScope(
                onWillPop: () async {
                  return !await Navigator.maybePop(
                    MyKeys.getKeys()[_selectedPage].currentState!.context,
                  );
                },
                child: IndexedStack(
                  index: _selectedPage,
                  children: tab,
                ),
              ),
            ),
          ),
          // SafeArea(
          //   key: const PageStorageKey<String>("perd"),
          //   bottom: false,
          //   child: Container(
          //     color: Colors.white,
          //     child: PageView(
          //         key: const PageStorageKey<String>("prdu"),
          //         controller: pageController,
          //         children: [
          //           Center(child: tab[0]),
          //           Center(child: tab[1]),
          //           Center(child: tab[2]),
          //           // Center(child: tab[3]),
          //         ]),
          //   ),
          // ),
        ),
      );}

    return indicator.isEmpty? principalPage(): transitionWidget();


  }
}


// Widget errorPageWidget(
//     {required BuildContext context,
//     required Function onTap,
//     required String assetImage,
//     String message = "Une erreur s'est produite lors du chargement de la page",
//     String buttonText = "Rafraîchir",
//     IconData icon = Icons.refresh,
//     double scale = 2,
//     bool buttonIsVisible = true}) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Image.asset(
//         assetImage,
//         fit: BoxFit.fitWidth,
//         scale: scale,
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Text(
//         message,
//         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       ),
//       const SizedBox(
//         height: 20,
//       ),
//       Visibility(
//         visible: buttonIsVisible,
//         child: Container(
//           height: 40,
//           alignment: AlignmentDirectional.center,
//           width: MediaQuery.of(context).size.width -
//               MediaQuery.of(context).size.width * 2 / 3,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                 color: recovaColor,
//               )),
//           child: InkWell(
//             onTap: () {
//               onTap();
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Icon(icon, color: recovaColor),
//                 Text(
//                   buttonText,
//                   style: const TextStyle(
//                       color: recovaColor, fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }






class RecovaHomePage1 extends StatefulWidget {
  final Function? pendingFunction;
  const RecovaHomePage1({Key? key, BuildContext? context, this.pendingFunction}) : super(key: key);

  @override
  _RecovaHomePageState1 createState() => _RecovaHomePageState1();
}

class _RecovaHomePageState1 extends State<RecovaHomePage1>
    with TickerProviderStateMixin {
  // final FlutterLocalization localization = FlutterLocalization.instance;
  final bucketGlobal = PageStorageBucket();
  String indicator = "";

  int bpage = 0;
  String pageTitle = "Tout";
  bool searchIsVisible = true;
  bool objectTypeIsVisible = true;
  Color firstPageColor = Colors.black12;

  PageController page = PageController();

  PageController pageController = PageController();
  TitleHomePage titleHomePage = TitleHomePage(title: "Tout",);
  int currentPage = 0;
  double lastPosition = 0.0;

  late List<Widget> tab;
  late int _selectedPage;

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Accueil",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.swap_vert),
      label: "Transactions",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Moi",
    )
  ];






  Future pendingFunctionExe() async {
    bool status = await widget.pendingFunction!();
    if (status) {
      setState(() {
        indicator = "";
      });
    } else {
      Navigator.of(context).pop();
    }
  }


  Future subscribeUserToNotification() async {
    if (SocketService.socket!.connected) return;
    if (await localBdSelectSetting("account") == "yes") {
      realNotificationService.initialize();
      String? id = await getId();
      print("voici d'id: $id");
      print("${await localBdSelectSetting("token")}");
      print(oneUserDataDico);
      if (oneUserDataDico.isEmpty) {
        // pendingPageFunction(context);
        await getOneUserDataById();
        // Navigator.of(context).pop();
        // showFooterUserAccountInfo(context);
      }


      SocketService.connectAndListenToSocket(await localBdSelectSetting("token"), id!, oneUserDataDico["id"]);
      SocketService.socket!.onAny((event, data) {
        // setState(() {});
        realNotificationService.showOnGoingNotification(id: 1, title: data["data"]["title"], body: data["data"].toString());
        try{
          // realNotificationService.showOnGoingNotification(flutterLocalNotificationsPlugin, id: data["data"]["id"]?? data["data"].hashCode, title: data["categorie"], body: data["data"]);
        } catch (e) {
          print("L'erreur des notifications: $e",);
        }
        print(data["data"]);
        print(event);
        // context.read<NotificationIconState>().changeNotificationCount(data);

      });
    }
  }

  void listenToNotification() => realNotificationService.onNotificationClick.stream.listen((event) {
    if (event!.isNotEmpty)  {
      print("Payload: $event");
    }
  });

  @override
  void initState() {
    // TODO: implement initState

    if (widget.pendingFunction != null) {
      indicator = "pending";
      pendingFunctionExe();
    }
    subscribeUserToNotification();
    listenToNotification();
    tab = [
      AccueilPage(key: const PageStorageKey<String>("Accueil"), navigatorKey: MyKeys.getKeys().elementAt(0)),
      const SizedBox(),
      const SizedBox()
    ];
    _selectedPage = 0;


    // print(fcmToken);
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

    // getOneUserDataById();
  }
  // final channel = IOWebSocketChannel.connect(
  //   Uri.parse('ws://localhost:3000/api/event'),
  // );

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


  // void onRegionSelect(String region) {
  //   setState(() {
  //     pageTitle = pageTitle.split("~").toList()[0] + (region == "Aucune"? "": "~$region");
  //     regionActuelle = region;
  //   });
  // }

  // void updateTitle(String newObjectType) {
  //   if (pageTitle.contains("~")) {
  //     pageTitle = "${newObjectType == "Aucune"? "": newObjectType}~${pageTitle.split("~").toList().last}";
  //   } else {
  //     pageTitle = newObjectType;
  //   }
  //
  // }



  @override
  Widget build(BuildContext context) {
    List<Color> gradiant = [recovaColor.withBlue(250), recovaColor, recovaColor.withBlue(250)];
    late int exPosition;

    // final List<NavigationBarButton> _itemResponsive = [
    //   NavigationBarButton(
    //     textColor: Colors.white,
    //     backgroundColor: recovaColor,
    //     text: 'Accueil',
    //     icon: Icons.home_filled,
    //     backgroundGradient: LinearGradient(
    //       colors: gradiant,
    //     ),
    //   ),
    //   NavigationBarButton(
    //     text: 'Transaction',
    //     icon: Icons.swap_vert,
    //     backgroundColor: recovaColor,
    //     backgroundGradient: LinearGradient(
    //       colors: gradiant,
    //     ),
    //   ),
    //   NavigationBarButton(
    //     text: 'Paramètre',
    //     icon: Icons.settings,
    //     backgroundColor: recovaColor,
    //     backgroundGradient: LinearGradient(
    //       colors: gradiant,
    //     ),
    //   ),
    // ];

    State state = titleHomePage.createState();
    state.activate();
    var statefulElement = titleHomePage.createElement();

    // Widget emptyPageWidget() {
    //   return errorPageWidget(context: context, onTap: (){
    //     showFooterActionPerdu(context);
    //   }, assetImage: "images/images-2.png",
    //       buttonText: "Ajouter", message: "Aucun objet retrouvé pour le moment", buttonIsVisible: true,
    //       scale: 0.65, icon: Icons.add_circle);
    // }



    // Widget listeObjecTypeSide() {
    //   const Color color  = recovaColor;
    //   const Color textColor = Colors.black;
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(0);
    //             // updateTitle("Tout");
    //             // titleState.changeTitle("Tout");
    //             // pageTitle = "Tout";
    //             // setState(() {});
    //           }, icon: const Icon(
    //             Icons.all_inclusive,
    //             color: color,
    //           ),),
    //           const Text("Tout", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(1);
    //             // updateTitle("CNI");
    //             // titleState.changeTitle("CNI");
    //
    //
    //             // pageTitle = "CNI";
    //             // setState(() {});
    //
    //           }, icon: const Icon(
    //             Icons.receipt,
    //             color: color,
    //           ),),
    //           const Text("CNI", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(2);
    //             // updateTitle("Passport");
    //             // titleState.changeTitle("Passport");
    //
    //             // pageTitle = "Passport";
    //             // setState(() {});
    //
    //           }, icon: const Icon(
    //             Icons.book,
    //             color: color,
    //           ),),
    //           const Text("Passport", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(3);
    //             // updateTitle("Permis de conduite");
    //             // titleState.changeTitle("Permis de conduite");
    //
    //             // pageTitle = "Permis de conduite";
    //             // setState(() {});
    //
    //           }, icon: const Icon(
    //             Icons.book_outlined,
    //             color: color,
    //           ),),
    //           const Text("Permis de conduite", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(4);
    //             // updateTitle("Enfant");
    //             // titleState.changeTitle("Enfant");
    //
    //             // pageTitle = "Enfant";
    //             // setState(() {});
    //
    //           }, icon: const Icon(
    //             Icons.person_outline,
    //             color: color,
    //           ),),
    //           const Text("Enfant", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(5);
    //             // updateTitle("Diplôme");
    //             // titleState.changeTitle("Diplôme");
    //
    //             // pageTitle = "Diplôme";
    //             // setState(() {});
    //
    //           }, icon: const Icon(
    //             Icons.school_outlined,
    //             color: color,
    //           ),),
    //           const Text("Diplôme", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(6);
    //             // updateTitle("Acte de naissance");
    //             // titleState.changeTitle("Acte de naissance");
    //
    //             // pageTitle = "Acte de naissance";
    //             // setState(() {});
    //           }, icon: const Icon(
    //             Icons.contact_page_outlined,
    //             color: color,
    //           ),),
    //           const Text("Acte de naissance", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //       Row(
    //         children: [
    //           IconButton(onPressed: () {
    //             page.jumpToPage(7);
    //             // updateTitle("Autres");
    //             // titleState.changeTitle("Autres");
    //
    //             // pageTitle = "Autres";
    //           // setState(() {});
    //           }, icon: const Icon(
    //             Icons.more_horiz,
    //             color: color,
    //           ),),
    //           const Text("Autres", style: TextStyle(color: textColor),)
    //         ],
    //       ),
    //     ],
    //   );
    // }

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

    // Widget listObjectHome(String categorie) {
    //   return FutureBuilder(
    //     builder: (ctx, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           // setState(() {
    //           firstPageColor = Colors.white;
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
    //             firstPageColor = Colors.white12;
    //             // });
    //             return HomePageListElement(
    //               data: data,
    //               context: context,
    //               state: () {
    //                 setState(() {});
    //               },
    //               scrollController: scrollController,
    //               key: UniqueKey(), categorie: categorie
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
    //     future: homePageGetAllObject(categorie, regionActuelle),
    //   );
    // }
    //
    // Widget mySideMenu(BuildContext context) {
    //   return Positioned(
    //     top: 100,
    //     left: 0,
    //     child: Material(
    //       color: Colors.transparent,
    //       child: listeObjecTypeSide()
    //       // SideMenu(
    //       //   controller: page,
    //       //   // title: SizedBox(height: 50,),
    //       //   footer: const Text('RECOVA'),
    //       //   // Notify when display mode changed
    //       //   onDisplayModeChanged: (mode) {
    //       //     print(mode);
    //       //   },
    //       //   // List of SideMenuItem to show them on SideMenu
    //       //   items: items,
    //       //   style: SideMenuStyle(
    //       //       displayMode: SideMenuDisplayMode.auto,
    //       //       openSideMenuWidth: 100,
    //       //       compactSideMenuWidth: 40,
    //       //       hoverColor: Colors.blue[100],
    //       //       selectedColor: recovaColor.withOpacity(0.3),
    //       //       selectedIconColor: recovaColor,
    //       //       unselectedIconColor: recovaColor,
    //       //       backgroundColor: Colors.transparent,
    //       //       selectedTitleTextStyle:
    //       //       const TextStyle(color: Colors.white),
    //       //       unselectedTitleTextStyle:
    //       //       const TextStyle(color: Colors.black54),
    //       //       iconSize: 20,
    //       //       itemBorderRadius: const BorderRadius.all(
    //       //         Radius.circular(5.0),
    //       //       ),
    //       //       showTooltip: true,
    //       //       itemHeight: 50.0,
    //       //       itemInnerSpacing: 8.0,
    //       //       itemOuterPadding:
    //       //       const EdgeInsets.symmetric(horizontal: 0.0),
    //       //       toggleColor: Colors.black54),
    //       // ),
    //     ),
    //   );
    // }


    // int n = 2;
    // List<Color> gradiant = [recovaColor.withBlue(250), recovaColor, recovaColor.withBlue(250)];
    Widget principalPage() {
      return PageStorage(
        bucket: bucketGlobal,
        key: const PageStorageKey<String>("pa"),
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          key: const PageStorageKey<String>("bf"),
          extendBodyBehindAppBar: true,
          // extendBody: true,
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   toolbarHeight: 35,
          //   title: StreamBuilder(
          //     stream: channel.innerWebSocket,
          //     builder: (context, snapshot) {
          //       print("voici snapshot: ${snapshot.data}");
          //       return Text(snapshot.hasData ? '${snapshot.data}' : '', style: const TextStyle(fontSize: 10),);
          //     },
          //   ),
          //   // FittedBox(child: Text(pageTitle, style: const TextStyle(fontSize: 17),)),
          //
          //   backgroundColor: recovaColor,
          //   foregroundColor: Colors.white,
          //   // bottom: ,
          //   actions: [
          //     // Text(AppLocalizations.of(context)!.helloWorld),
          //     // Text(AppLocalizations.of(context)!.hello),
          //     // Drawer(),
          //     Stack(
          //         children: [
          //           IconButton(onPressed: (){
          //             // localization.translate('en');  http://localhost:3000/api/event
          //             // print(localization.getLanguageName());
          //             // Navigator.of(context).pushNamed("Demo");
          //             final channel = IOWebSocketChannel.connect(
          //               // Uri.parse('ws://localhost:3000/api/event'),
          //               Uri.parse('ws://localhost:3000/message'),
          //             );
          //             print(channel.stream);
          //             context.read<NotificationIconState>().changeNotificationCount(n);
          //             ++n;
          //           }, icon: const Icon(Icons.language)),
          //           Positioned(
          //             child: BlocBuilder<NotificationIconState, int>(builder: (BuildContext context, state) {
          //               return Text("$state", style: const TextStyle(fontSize: 10),);
          //             },
          //             ),
          //           )
          //         ]
          //     ),
          //     Visibility(
          //       visible: searchIsVisible,
          //       child: CircleAvatar(
          //         backgroundColor: Colors.white10,
          //         child: IconButton(
          //             onPressed: () {
          //               showModalBottomSheet(
          //                 transitionAnimationController: AnimationController(
          //                     vsync: this,
          //                     duration: const Duration(milliseconds: 800),
          //                     animationBehavior: AnimationBehavior.preserve,
          //                     reverseDuration: const Duration(milliseconds: 500)),
          //                 isScrollControlled: true,
          //                 shape: const RoundedRectangleBorder(
          //                   borderRadius:
          //                   BorderRadius.vertical(top: Radius.circular(15.0)),
          //                 ),
          //                 context: context,
          //                 builder: (context) {
          //                   return StatefulBuilder(
          //                     builder:
          //                         (BuildContext context, StateSetter setState) {
          //                       return DraggableScrollableSheet(
          //                         maxChildSize: 0.9,
          //                         initialChildSize: 0.9,
          //                         minChildSize: 0.13,
          //                         expand: false,
          //                         builder: (BuildContext context,
          //                             ScrollController scrollController) {
          //                           return const RecovaSarchWidget();
          //                         },
          //                       );
          //                     },
          //                   );
          //                 },
          //               );
          //             },
          //             icon: const Icon(
          //               Icons.search,
          //               color: Colors.white,
          //               size: 25,
          //             )),
          //       ),
          //     ),
          //     // Visibility(
          //     //     child: PopupMenuButton(
          //     //         elevation: 14,
          //     //         initialValue: regionActuelle,
          //     //         // onCanceled: () => print("Vous n'avez rien selectionné"),
          //     //         onSelected: onRegionSelect,
          //     //         itemBuilder: (BuildContext context) {
          //     //           return (["Aucune"] + camerounRegion).map((String region) {
          //     //             return PopupMenuItem<String>(
          //     //               value: region,
          //     //               child: Text(region),
          //     //             );
          //     //           }).toList();
          //     //         },
          //     //       // color: Colors.white10,
          //     //         child: const CircleAvatar(
          //     //         backgroundColor: Colors.white10,
          //     //           child: Icon(Icons.sort, color: Colors.white,),
          //     //         )),)
          //   ],
          // ),
          // drawer: const RecoverDrawerMenu(),
          drawerScrimColor: recovaColor,
          bottomNavigationBar: BlocBuilder<BottomNavigationBarState, bool>(builder: (BuildContext context, state) {
            return Visibility(
              visible: state,
              child: Container(
                decoration: BoxDecoration(
                    color: recovaColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  selectedItemColor: recovaColor,
                  unselectedItemColor: Colors.black,
                  elevation: 15,
                  selectedFontSize: 17,
                  showUnselectedLabels: false,
                  // type: BottomNavigationBarType.shifting,
                  selectedLabelStyle: const TextStyle(color: Colors.black),
                  items: _items,
                  currentIndex: _selectedPage,
                  onTap: (index) {
                    setState(() {
                      if (tab[index] is SizedBox) {
                        if (index == 1) {
                          tab[index] = const UserTransactionPage();
                        } else {
                          tab[index] = const UserAccountPage(key: PageStorageKey<String>("UserAccountPage"));
                        }
                      }
                      _selectedPage = index;
                    });
                  },
                ),
              ),
            );
          },
          ),


          // ResponsiveNavigationBar(
          //   backgroundBlur: 0.5,
          //   backgroundOpacity: 0.5,
          //   backgroundColor: Colors.white,
          //   selectedIndex: currentPage,
          //   activeIconColor: Colors.white,
          //   inactiveIconColor: Colors.black,
          //   onTabChange: (index) {
          //     setState(() {
          //       if (tab[index] is SizedBox) {
          //         if (index == 1) {
          //           tab[index] = const UserTransactionPage();
          //         } else {
          //           tab[index] = const UserAccountPage(key: PageStorageKey<String>("UserAccountPage"));
          //         }
          //       }
          //       _selectedPage = index;
          //     });
          //     // setState(() {
          //     //   currentPage = index;
          //     // });
          //     // pageController.animateToPage(
          //     //     index, duration: const Duration(milliseconds: 100),
          //     //     curve: Curves.bounceIn);
          //
          //   },
          //   textStyle: const TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   navigationBarButtons: _itemResponsive,
          // ),
/*



 */
          //     CurvedNavigationBar(
          //   color: recovaColor,
          //   height: 50,
          //   items: <Widget>[
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.home_filled,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Acueil", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.find_in_page_outlined,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text(
          //           "Perdu",
          //           style: TextStyle(color: Colors.white),
          //         )
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.data_saver_on_outlined,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Retrouvé", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //     Column(
          //       children: const [
          //         Icon(
          //           Icons.person,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         Text("Mon compte", style: TextStyle(color: Colors.white))
          //       ],
          //     ),
          //   ],
          //   backgroundColor: Colors.white12,
          //   animationCurve: Curves.fastLinearToSlowEaseIn,
          //   animationDuration: const Duration(milliseconds: 1000),
          //   onTap: (index) {
          //     pageController.animateToPage(index, duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
          //
          //     // setState(() {
          //     //
          //     //   bpage = index;
          //     //   switch (bpage) {
          //     //     case 0:
          //     //       pageTitle = "RECOVA";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 1:
          //     //       pageTitle = "--";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 2:
          //     //       pageTitle = "--";
          //     //       searchIsVisible = true;
          //     //       break;
          //     //     case 3:
          //     //       pageTitle = "Mon compte";
          //     //       searchIsVisible = false;
          //     //   }
          //     // });
          //   },
          // ),
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: WillPopScope(
                onWillPop: () async {
                  return !await Navigator.maybePop(
                    MyKeys.getKeys()[_selectedPage].currentState!.context,
                  );
                },
                child: IndexedStack(
                  index: _selectedPage,
                  children: tab,
                ),
              ),
            ),
          ),
          // SafeArea(
          //   key: const PageStorageKey<String>("perd"),
          //   bottom: false,
          //   child: Container(
          //     color: Colors.white,
          //     child: PageView(
          //         key: const PageStorageKey<String>("prdu"),
          //         controller: pageController,
          //         children: [
          //           Center(child: tab[0]),
          //           Center(child: tab[1]),
          //           Center(child: tab[2]),
          //           // Center(child: tab[3]),
          //         ]),
          //   ),
          // ),
        ),
      );}

    return indicator.isEmpty? principalPage(): transitionWidget();


  }
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


class MyKeys {
  static final first = GlobalKey(debugLabel: 'page1');
  static final second = GlobalKey(debugLabel: 'page2');
  static final third = GlobalKey(debugLabel: 'page3');

  static List<GlobalKey> getKeys() => [first, second, third];
}