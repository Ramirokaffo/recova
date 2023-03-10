import 'package:flutter/material.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/childrenRecoverPage.dart';
import 'package:projet_flutter2/OtherRecoverObjectPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/main.dart';
import 'RecovaFormRetrouvePage.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';




class HomeRetrouvePage extends StatefulWidget {
  const HomeRetrouvePage({Key? key}) : super(key: key);

  @override
  _HomeRetrouvePageState createState() => _HomeRetrouvePageState();
}

class _HomeRetrouvePageState extends State<HomeRetrouvePage> {
  String? def;
  List<DropdownMenuItem<String>> ListObjectType = [];
  String recoverDate = DateTime.now().toString();
  final bucketGlobal = PageStorageBucket();
  bool isAllLoading = true;
  Future pendingFunction() async {
    await newGetAllObjectType();
    await getOneUserDataById();
    try {
      setState(() {isAllLoading = false;});
    } catch (e) {
      //
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    if (isAllLoading) {
      pendingFunction();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isAllLoading? transitionWidget2(): PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: CircleAvatar(
          backgroundColor: recovaColor,
          radius: 25,
          child: IconButton(
              onPressed: () {
                showFooterActionRetrouve(context);
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
                          context: context),
                    );
                  } else if (snapshots.hasData) {
                    final datas = snapshots.data as List;
                    if (datas.isNotEmpty) {
                      return BuilListObjectLoseOrRecover(data: datas, pageStorageKey: PageStorageKey("home perdu"), categorie: "R");
                    } else {
                      return Center(
                        child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/3278_R1NUIENBTSA2MDktNjA.jpg",
                            context: context, message: "Aucun objet égaré pour le moment", buttonText: "Ajouter", icon: Icons.add_circle),
                      );
                    }
                  }
                }
                return transitionWidget2();
              },
              future: selectListObjectsWithRoute(
                  allRecoverObjectRoute, recoverObjectList),
            ),
          ),
        ),
      ),
    );
    ;
  }
}

Widget oneOptionToShow({required String title, required Function() onTap, IconData? icon, double? size}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          // color: recovaColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
               Expanded(
                  flex: 1,
                  child: Icon(icon ?? Icons.circle, size: 20, color: recovaColor)),
              const SizedBox(width: 3,),
              Expanded(
                flex: 10,
                child: Text(
                  title,
                  style: TextStyle(
                      color: recovaColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size ?? 30),
                ),
              ),
              const Expanded(
                flex: 1,
                child: Icon(Icons.arrow_forward_ios_outlined,
                    size: 20, color: recovaColor),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
