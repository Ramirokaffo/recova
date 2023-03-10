import 'package:flutter/material.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/OneObjectDataShowPage.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/main.dart';
import 'package:projet_flutter2/HomeRetrouvePage.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';




class HomePerduPage extends StatefulWidget {
  const HomePerduPage({Key? key}) : super(key: key);

  @override
  _HomePerduPageState createState() => _HomePerduPageState();
}
// with TickerProviderStateMixin
class _HomePerduPageState extends State<HomePerduPage> with TickerProviderStateMixin {
  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;
  final bucketGlobal = PageStorageBucket();
  PageStorageKey<String> pageStorageKey = const PageStorageKey("home egare");


  @override
  initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
    // rippleController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // scaleAnimation = AnimationController(vsync: this, duration: const Duration(seconds: 2))
    //             ..addStatusListener((status) {
    //               if (status == AnimationStatus.completed) {
    //                 scaleController.reverse();
    //                 // Navigator.push(context, ZoomPageTransitionsBuilder)
    //               }
    //             });
    //
  }


  @override
  void dispose() {
    // rippleController.dispose();
    // scaleController.dispose();
    // _controller.dispose();
    super.dispose();
  }


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                showFooterActionPerdu(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              builder: (ctx, snapshots) {
                if (snapshots.connectionState == ConnectionState.done) {
                  if (snapshots.hasError) {
                    return Center(
                      child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                          context: context)
                    );
                  } else if (snapshots.hasData) {
                    final datas = snapshots.data as List;
                    if (datas.isNotEmpty) {
                      return BuilListObjectLoseOrRecover(data: datas, pageStorageKey: pageStorageKey, categorie: "P",);
                    } else {
                      return Center(
                        child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/3278_R1NUIENBTSA2MDktNjA.jpg",
                            context: context, message: "Aucun objet égaré pour le moment", buttonText: "Ajouter", icon: Icons.add_circle)
                      );
                    }
                  }
                }
                return  transitionWidget2();
              },
              future:
                  selectListObjectsWithRoute(loseObjectRoute, lostObjectList),
            ),
          ),
        ),
      ),
    );
  }
}




class MyCustomPageAnimationTransition extends PageRouteBuilder {
  final Widget enterWidget;

  MyCustomPageAnimationTransition(this.enterWidget): super(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => enterWidget,
    transitionDuration: const Duration(milliseconds: 1500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation = CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn, reverseCurve: Curves.fastOutSlowIn);
    return ScaleTransition(scale: animation, alignment: const Alignment(0.9,0.9), child: child,);
    }
  );
}