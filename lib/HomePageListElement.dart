import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_flutter2/HomePerduPage.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/RecovaProofOwnerPage.dart';
import 'package:projet_flutter2/cubit/NetWorkImageState.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/OneObjectDataShowPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/cubit/BottomNavigationBarState.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';

class HomePageListElement extends StatefulWidget {
  List<dynamic> data;
  Function? state;
  ScrollController scrollController;
  String categorie;

  HomePageListElement(
      {super.key,
      required this.data,
      required BuildContext context,
      this.state,
      required this.scrollController, required this.categorie});

  @override
  _HomePageListElement createState() => _HomePageListElement();
}

class _HomePageListElement extends State<HomePageListElement>
    with TickerProviderStateMixin {

  double lastPosition = 0.0;

  Widget own_item_builder(
    int val,
    BuildContext context,
    Key? key,
  ) {
    bool isImageAvalaible = true;
    context
        .read<NetWorkImageState>()
        .changeNotificationCount(widget.data[val]["image"]);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 4, offset: Offset(0, 4))
              ]),
          child: InkWell(
            radius: 130,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 4, offset: Offset(0, 4))
                  ]),
              child: Column(
                children: [
                  Text(
                    widget.data[val]["objectType"] == 9
                        ? widget.data[val]["otherType"]
                        : '${objectIdToName[widget.data[val]["objectType"]]!}  ${widget.categorie == 'R' ? "Retrouvé(e)" : "égaré(e) "}',
                    style: const TextStyle(
                        color: recovaColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: widget.data[val]["id"],
                        child:
                        BlocBuilder<NetWorkImageState, String>(builder: (BuildContext context, state) {
                          return FadeInImage.assetNetwork(
                                                  placeholder: placeholder,
                                                  image: state,
                                                  width: double.infinity,
                                                  // height: double.infinity,
                                                  fit: BoxFit.contain,                          // width: MediaQuery.of(context).size.width,
                                                  imageErrorBuilder: (context, object, stackTrace) {
                                                    isImageAvalaible = false;
                                                    return Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 200,
                                                      color: Colors.white,
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 100,
                                                          ),
                                                          Center(
                                                              child: IconButton(onPressed: (){
                                                                context
                                                                    .read<NetWorkImageState>()
                                                                    .changeNotificationCount(widget.data[val]["image"]);

                                                                // setState(() {
                                                                // });
                                                              }, icon: const Icon(Icons.refresh))),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                        }
                        ,
                      ),
                      )
                      // title: Text("image"),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ExpansionTile(
                      // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      key: const PageStorageKey<String>("plpl"),
                      iconColor: recovaColor,
                      childrenPadding: EdgeInsetsGeometry.lerp(
                          const EdgeInsets.only(left: 2),
                          const EdgeInsets.only(left: 2),
                          1),
                      collapsedIconColor: recovaColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Visibility(
                            visible: (widget.data[val]["loseSide"] !=
                                    null || widget.data[val]["nowSide"] != null),
                            child: Text(
                                "${widget.data[val]["loseSide"] ?? widget.data[val]["nowSide"]}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                textAlign: TextAlign.start),
                          ),
                          Text(
                            widget.data[val]["createAt"] != Null ? dateTransorm(widget.data[val]["createAt"].toString()) : "Aucun",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      children: <Widget>[
                        const Divider(
                          height: 1,
                          color: recovaColor,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Visibility(
                                    visible: (widget.data[val]
                                            ["objectNumber"] !=
                                        null),
                                    child: Text(
                                      "Numero: ${widget.data[val]["objectNumber"]}",
                                      style: const TextStyle(
                                        color: recovaColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (widget.data[val]["objectName"] !=
                                        null),
                                    child: Text(
                                      "Nom: ${widget.data[val]["objectName"]}",
                                      style: const TextStyle(
                                        color: recovaColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (widget.data[val]
                                            ["objectDescription"] !=
                                        null),
                                    child: Text(
                                      "Détails: ${widget.data[val]["objectDescription"]}",
                                      style: const TextStyle(
                                        color: recovaColor,
                                        fontSize: 15,
                                      ),
                                      maxLines: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: recovaColor,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Container(
                        width: 410,
                        color: Colors.white,
                        child: TextButton(
                            onPressed: () async {
                              // print(widget.data[val]);
                              curentObjectCategorie = widget.categorie;
                              propertyOrRecoverManager(
                                  context, widget.data[val], widget.categorie);
                            },
                            child: Text(
                              widget.categorie == 'R'
                                  ? "C'est ma propriété"
                                  : "J'ai retrouvé",
                              style: const TextStyle(color: recovaColor),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (isImageAvalaible) {
                // Navigator.of(context).push(
                //     MyCustomPageAnimationTransition(DisplaysImage(
                //       key: UniqueKey(),
                //       image: widget.data[val]["image"],
                //     ),));
                // var route = MaterialPageRoute(
                //   builder: (BuildContext context) => DisplaysImage(
                //     key: UniqueKey(),
                //     image: widget.data[val]["image"],
                //   ),
                // );
                // Navigator.of(context).push(route);
                var route = PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DisplaysImage(
                    key: UniqueKey(),
                    image: widget.data[val]["image"],
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    animation = CurvedAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        parent: animation);
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
                Navigator.of(context).push(route);
              }
            },
            onLongPress: () {
              // var route = PageRouteBuilder(
              //
              //   pageBuilder: (context, animation, secondaryAnimation) => SecondePage(
              //     key: UniqueKey(),
              //     recover_object_id: val, ojectList: widget.data,
              //   ),
              //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //     animation = CurvedAnimation(curve: Curves.ease, parent: animation);
              //     return FadeTransition(opacity: animation, child: child,);
              //   },
              // );
              // Navigator.of(context).push(route);
              print("widget.data: ${widget.data}");
              Navigator.of(context).push(MyCustomPageAnimationTransition(
                SecondePage(
                  key: UniqueKey(),
                  recover_object_id: val,
                  ojectList: widget.data,
                ),
              ));

              // var route = MaterialPageRoute(
              //   builder: (BuildContext context) => SecondePage(
              //     key: UniqueKey(),
              //     recover_object_id: val, ojectList: widget.data,
              //   ),
              // );
              // Navigator.of(context).push(route);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.hasClients) {
        if (lastPosition < widget.scrollController.position.pixels) {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(false);
        } else {
          context
              .read<BottomNavigationBarState>()
              .changeNotificationCount(true);
        }
      }
      lastPosition = widget.scrollController.position.pixels;
    });

  }
  @override
  Widget build(BuildContext context) {
    print("Je suis en trsin de m'executer");


    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(right: 3, left: 3),
      child: Scrollbar(
        controller: widget.scrollController,
        child: ListView.builder(
          key: PageStorageKey<String>("popo${widget.data.hashCode}"),
          controller: widget.scrollController,
          itemCount: widget.data.isEmpty ? 0 : widget.data.length,
          itemBuilder: (context, val) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                own_item_builder(
                  val,
                  context,
                  PageStorageKey<String>("homepage$val"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Future propertyOrRecoverManager(
    BuildContext context, Map<String, dynamic> data, String categorie) async {
  // showFooterActionSelectMoyenRcouvrement(context, data["id"]);
  // return;
  if ((await localBdSelectSetting("token")) == "none") {
    checkUnautoriseUser(context);
    return;
  }
  curentObjectIndex = data["id"];
  if (categorie == "R") {
    String oc = (await getobjectTypeCategorieById(data["objectType"]))[0]
        ["objectTypeCategorie"];
    if (["PP", "DO"].contains(oc)) {
      objectNeedProofDialog(
          context,
          "Vous devez apporter une preuve de propriété en fournissant la photo "
          "d'un document officiel portant vos informations personnelles.");
    } else if (oc == "E") {
      objectNeedProofDialog(
          context,
          "Vous devez apporter une preuve de propriété en fournissant la photo "
          "d'un document officiel qui vous lie avec l'enfant.");
    }
    else {
      showFooterActionSelectMoyenRcouvrement(context, curentObjectIndex);
    }
  } else {
    objectNeedProofDialog(
        context,
        "Cet objet a été declaré perdu; vous êtes sûr de l'avoir retrouvé ? \n\n"
            "NB: Vous devez envoyer une image de l'objet comme preuve",
    title: "RECOVA");
    // docOfficielLoseDialog1(context, categorie);
  }
}

// class _HomePageListElement extends State<HomePageListElement>  with TickerProviderStateMixin
// {
//
//
//
//   Widget own_item_builder(
//       int val,
//       BuildContext context,
//       Key? key,
//       ) {
//     bool isImageAvalaible = true;
//     return Column(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Colors.grey, blurRadius: 4, offset: Offset(0, 4))
//               ]),
//           child: InkWell(
//             radius: 130,
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: recovaColor,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.grey, blurRadius: 4, offset: Offset(0, 4))
//                   ]),
//               child: Column(
//                 children: [
//                   Text(
//                     widget.data[val]["objectType"] == Null
//                         ? "Aucun"
//                         : '${objectIdToName[widget.data[val]["objectType"]]!}  ${widget.data[val]["categorie"] == 'R'
//                         ? "Retrouvé(e)"
//                         : "égaré(e) "}',
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5)),
//                       child: Hero(
//                         tag: widget.data[val]["id"],
//                         child: FadeInImage.assetNetwork(
//                           placeholder: "images/Curve-Loading.gif",
//                           image: widget.data[val]["image"],
//                           width: MediaQuery.of(context).size.width,
//                           imageErrorBuilder: (context, object, stackTrace) {
//                             isImageAvalaible = false;
//                             return Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: 200,
//                               color: Colors.white,
//                               child: Column(
//                                 children: const [
//                                   SizedBox(
//                                     height: 100,
//                                   ),
//                                   Center(child: Text("Erreur lors du chargement de l'image...", style: TextStyle(color: Colors.red),)),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       // title: Text("image"),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: ExpansionTile(
//                       key: const PageStorageKey<String>("plpl"),
//                       iconColor: recovaColor,
//                       childrenPadding: EdgeInsetsGeometry.lerp(EdgeInsets.only(left: 2), EdgeInsets.only(left: 2), 1),
//                       collapsedIconColor: recovaColor,
//                       title: Row(
//                         children: <Widget>[
//                           Container(
//                             alignment: Alignment.topLeft,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Visibility(
//                                   visible: (widget.data[val]["loseOrNowSide"] != null && widget.data[val]["categorie"] == "R"),
//                                   child: Text(
//                                       "lieu: ${widget.data[val]["loseOrNowSide"]}",
//                                       style: const TextStyle(
//                                           color: recovaColor, fontSize: 15),
//                                       textAlign: TextAlign.start),
//                                 ),
//                                 Text(
//                                   "date: ${widget.data[val]["recoverOrLoseDate"] != Null ? dateTransorm(widget.data[val]["recoverOrLoseDate"].toString()) : "Aucun"}",
//                                   style: const TextStyle(
//                                       color: recovaColor, fontSize: 15),
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       children: <Widget>[
//                         const Divider(
//                           height: 1,
//                           color: recovaColor,
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10, top: 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Visibility(
//                                     visible: (widget.data[val]["objectNumber"] != null),
//                                     child: Text(
//                                       "Numero: ${widget.data[val]["objectNumber"]}",
//                                       style: const TextStyle(
//                                         color: recovaColor,
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: (widget.data[val]["objectName"] != null),
//                                     child: Text(
//                                       "Nom: ${widget.data[val]["objectName"]}",
//                                       style: const TextStyle(
//                                         color: recovaColor,
//                                         fontSize: 15,
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: (widget.data[val]["objectDescription"] != null),
//                                     child: Text(
//                                       "Détails: ${widget.data[val]["objectDescription"]}",
//                                       style: const TextStyle(
//                                           color: recovaColor, fontSize: 15),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(
//                     height: 1,
//                     color: recovaColor,
//                   ),
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(30),
//                         bottomRight: Radius.circular(30),
//                       ),
//                       child: Container(
//                         width: 410,
//                         color: recovaColor,
//                         child: TextButton(
//                             onPressed: () async {
//                               propertyOrRecoverManager(context, widget.data[val]);
//                             },
//                             child: Text(
//                               widget.data[val]["categorie"] == 'R'
//                                   ? "C'est ma propriété"
//                                   : "J'ai retrouvé",
//                               style: const TextStyle(color: Colors.white),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               if (isImageAvalaible) {
//
//
//
//                 // Navigator.of(context).push(
//                 //     MyCustomPageAnimationTransition(DisplaysImage(
//                 //       key: UniqueKey(),
//                 //       image: widget.data[val]["image"],
//                 //     ),));
//                 // var route = MaterialPageRoute(
//                 //   builder: (BuildContext context) => DisplaysImage(
//                 //     key: UniqueKey(),
//                 //     image: widget.data[val]["image"],
//                 //   ),
//                 // );
//                 // Navigator.of(context).push(route);
//                 var route = PageRouteBuilder(
//                   transitionDuration: const Duration(milliseconds: 2000),
//                   pageBuilder: (context, animation, secondaryAnimation) => DisplaysImage(
//                     key: UniqueKey(),
//                     image: widget.data[val]["image"],
//                   ),
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     animation = CurvedAnimation(curve: Curves.fastLinearToSlowEaseIn, parent: animation);
//                     return FadeTransition(opacity: animation, child: child,);
//                   },
//                 );
//                 Navigator.of(context).push(route);
//               }
//             },
//             onLongPress: () {
//
//
//               // var route = PageRouteBuilder(
//               //
//               //   pageBuilder: (context, animation, secondaryAnimation) => SecondePage(
//               //     key: UniqueKey(),
//               //     recover_object_id: val, ojectList: widget.data,
//               //   ),
//               //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               //     animation = CurvedAnimation(curve: Curves.ease, parent: animation);
//               //     return FadeTransition(opacity: animation, child: child,);
//               //   },
//               // );
//               // Navigator.of(context).push(route);
//
//
//               Navigator.of(context).push(
//                   MyCustomPageAnimationTransition(SecondePage(
//                     key: UniqueKey(),
//                     recover_object_id: val, ojectList: widget.data,
//                   ),));
//
//
//               // var route = MaterialPageRoute(
//               //   builder: (BuildContext context) => SecondePage(
//               //     key: UniqueKey(),
//               //     recover_object_id: val, ojectList: widget.data,
//               //   ),
//               // );
//               // Navigator.of(context).push(route);
//             },
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       padding: const EdgeInsets.only(right: 3, left: 3),
//       child: Scrollbar(
//         controller: widget.scrollController,
//         child: ListView.builder(
//           key: PageStorageKey<String>("popo"),
//           controller: widget.scrollController,
//           itemCount: widget.data.isEmpty ? 0 : widget.data.length,
//           itemBuilder: (context, val) {
//             return Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 own_item_builder(val, context, PageStorageKey<String>("homepage"),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

void sendProofImage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        title: const Text(
          "Preuve de propriété",
          style: TextStyle(
            color: recovaColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        content: const RecovaProofOwnerWidget(),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white)),
                child: const Text(
                  "Annuler",
                  style: TextStyle(fontSize: 18, color: recovaColor),
                ),
                onPressed: () {
                  objectImageData["name"] = "";
                  objectImageData["path"] = "";
                  Navigator.maybePop(context);
                },
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  if (objectImageData["path"] != Null &&
                      !curentObjectIndex.isNaN) {
                    var status = await sendProofOwnerImage(
                        imagesPath: objectImageData["path"]!,
                        imageName: objectImageData["name"]!,
                        objectId: curentObjectIndex,
                    categorie: curentObjectCategorie);
                    print("status: $status");
                    if (status["status"] == "yes") {
                      Navigator.of(context).pop();
                      showSimpleDialog(
                          title: "RECOVA",
                          context: context,
                          message:
                              "Votre requête est en cours de traitement, vous recevrez la confirmation dans quelques instants");
                    } else {
                      showSimpleSnackbar(
                          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                          message:
                              "Une erreur s'est produite veuillez reéssayer",
                          context: context);
                    }
                  } else {
                    showSimpleSnackbar(
                        rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                        message: "Veuillez sélectinner l'image",
                        context: context);
                  }
                },
                child: const Text(
                  "Envoyer",
                  style: TextStyle(fontSize: 18, color: recovaColor),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void objectNeedProofDialog(BuildContext context, String message,
    {String title = "Preuve de propriété"}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: recovaColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(color: recovaColor,)
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(fontSize: 16, color: recovaColor),
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    "En savois plus",
                    style: TextStyle(fontSize: 16, color: recovaColor),
                  ),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showFooterActionImagePerduChoice(
                        context: context, refreshParentState: sendProofImage);
                  },
                  child: const Text(
                    "Preuve",
                    style: TextStyle(fontSize: 16, color: recovaColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void showMontantPaiementDialog(
    {required BuildContext context,
    required String message,
    required Function onValidate,
    required Function onDetailsPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: const [
            Text(
              "Paiement",
              style: TextStyle(
                color: recovaColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(
              color: recovaColor,
            )
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text(
                  "Annuler",
                  style: TextStyle(
                      fontSize: 18,
                      color: recovaColor,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white)),
                child: const Text(
                  "Détails",
                  style: TextStyle(
                      fontSize: 18,
                      color: recovaColor,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  onDetailsPressed();
                },
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  onValidate();
                },
                child: const Text(
                  "Continuer",
                  style: TextStyle(
                      fontSize: 18,
                      color: recovaColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void showFooterActionSelectMoyenRcouvrement(
    BuildContext context, int objectId) async {
  showWaitTransitionWidget(context);
  var data = await getRightLosePriceByObjectId(objectId);
  // return;
  Navigator.pop(context);
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              color: recovaColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: recovaColor,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 10,
                      child: Text(
                        "Moyen de recouvrement",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              const Divider(
                height: 50,
                color: Colors.white,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  title: const Text("J'irai prendre moi-même",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  subtitle: Text(
                    "Coût: ${data["takePrice"]} XAF",
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white),
                  onTap: () {
                    showMontantPaiementDialog(
                        context: context,
                        message:
                            "Vous serez facturé d'un montant de ${data["takePrice"]} XAF !\n"
                            "Pour plus de détails sur la repartition de cette somme, cliquez sur DETAILS",
                        onValidate: () {
                          Navigator.of(context).pop();
                          showFooterActionSelectMoyenPaiement(context);
                        },
                        onDetailsPressed: () {});
                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  // leading: Icon(Icons.circle, color: Colors.white),
                  title: const Text("Je veux qu'on vienne me donner",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  subtitle: Text(
                    "Coût: ${data["givePrice"]} XAF",
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white),
                  onTap: () {
                    showMontantPaiementDialog(
                        context: context,
                        message:
                            "Vous serez facturé d'un montant de ${data["givePrice"]} XAF !\n"
                            "Pour plus de détails sur la repartition de cette somme, cliquez sur DETAILS",
                        onValidate: () {
                          Navigator.of(context).pop();
                          showFooterActionSelectMoyenPaiement(context);
                        },
                        onDetailsPressed: () {});
                  },
                ),
              ),
            ],
          ),
        );
      });
}

void showFooterActionSelectMoyenPaiement(BuildContext context) async {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              color: recovaColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: recovaColor,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 10,
                      child: Text(
                        "Moyen de paiement",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              const Divider(
                height: 50,
                color: Colors.white,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2)
                ),
                child: ListTile(
                  title: const Text("MTN Mobile Money",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  leading: Image.asset(
                    "images/IMG_8372.WEBP",
                    height: 50,
                    width: 50,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white),
                  onTap: () {
                    showFooterActionEnterNumberPaiement(context, "MOMO");
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.2)
                ),
                child: ListTile(
                  // leading: Icon(Icons.circle, color: Colors.white),
                  title: const Text("Orange Money",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  leading: Image.asset(
                    "images/IMG_8374.PNG",
                    height: 50,
                    width: 50,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white),
                  onTap: () {
                    showFooterActionEnterNumberPaiement(context, "OM");

                  },
                ),
              ),
            ],
          ),
        );
      });
}

void showFooterActionEnterNumberPaiement(BuildContext context, String operateur) async {
  TextEditingController controller = TextEditingController(
      text: oneUserDataDico["telephone"].toString().isEmpty
          ? userCountryCode
          : oneUserDataDico["telephone"]);

  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              color: recovaColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: recovaColor,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 10,
                      child: Text(
                        "Numéro du paiement",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20), textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              Image.asset((operateur == "MOMO")? "images/IMG_8372.WEBP": "images/IMG_8374.PNG",
              height: 75, width: 75,),
              const Divider(
                height: 50,
                color: Colors.white,
              ),
              TextFormField(
                autocorrect: false,
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: const InkWell(
                        child: Text(
                          "Continuer",
                          style: TextStyle(color: recovaColor, fontSize: 25),
                          textAlign: TextAlign.center,
                        ),
                      )))
            ],
          ),
        );
      });
}

void docOfficielLoseDialog1(BuildContext context, String categorie) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "RECOVA",
          style: TextStyle(
            color: recovaColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Divider(color: recovaColor,),
            Text(
              "Cet objet a été declaré perdu; vous êtes sûr de l'avoir retrouvé ? \n",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              "NB: En cliquant sur CONFIRMER vous autorisez RECOVA à envoyer votre contact au propriétaire.",
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    color: recovaColor,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text(
                        "Annuler",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Material(
                    color: recovaColor,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        var status =
                            await recoverChangeNRtoR(curentObjectIndex, "R", categorie);
                        print("$status: ${status.runtimeType}");
                        if (status["status"] == "yes") {
                          showSimpleDialog(
                              title: "RECOVA",
                              context: context,
                              message:
                                  "Votre requête est en cours de traitement; le propriétaire ou un agent RECOVA va vous contacter\n\n"
                                  "RECOVA vous remercie!");
                        } else {
                          showSimpleDialog(
                              title: "RECOVA",
                              context: context,
                              message: "La requête a échouée, veuillez reéssayer");
                        }
                      },
                      child: const Text(
                        "Confirmer",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

// void docOfficielRecoverDialog2(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(
//           "RECOVA",
//           style: TextStyle(
//             color: recovaColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         content: const Text(
//           "Cet objet a été declaré perdu; vous être sûr de l'avoir retrouvé ?",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         actions: <Widget>[
//           Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: 150,
//                   child: Material(
//                     elevation: 10,
//                     borderRadius: BorderRadius.circular(10),
//                     color: recovaColor.withOpacity(0.8),
//                     child: TextButton(
//                       style: ButtonStyle(
//                         overlayColor: MaterialStateProperty.all(Colors.white),
//                       ),
//                       child: const Text(
//                         "Annuler",
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                       onPressed: () {
//                         Navigator.maybePop(context);
//                       },
//                     ),
//                   ),
//                 ),
//                 Material(
//                   color: recovaColor.withOpacity(0.8),
//                   elevation: 10,
//                   borderRadius: BorderRadius.circular(10),
//                   child: TextButton(
//                     style: ButtonStyle(
//                         overlayColor: MaterialStateProperty.all(Colors.white)),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       showFooterActionImagePerduChoice(
//                           context: context, refreshParentState: sendProofImage);
//                     },
//                     child: const Text(
//                       "Oui je suis sûr",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

class BuilListObjectLoseOrRecover extends StatelessWidget {
  List<dynamic> data;
  PageStorageKey<String>? pageStorageKey;
  String categorie;

  BuilListObjectLoseOrRecover(
      {Key? key, required this.data, this.pageStorageKey, required this.categorie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget ownItemToDisplays(int val, IconData icon) {
      return InkWell(
        radius: 130,
        borderRadius: BorderRadius.circular(60),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              ListTile(
                // isThreeLine: true,
                leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: recovaColor,
                    child: Icon(
                      icon,
                      color: Colors.white,
                    )),
                trailing: Text(
                  dateTransorm(data[val]["createAt"].toString()),
                  style: const TextStyle(
                    color: recovaColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                title: Text(
                  '${objectIdToName[data[val]["objectType"]]!} ${data[val]["objectType"] == 9 ? "" : categorie == "R" ? "retrouvé(e)" : "égaré(e)"}',
                  style: const TextStyle(
                    color: recovaColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                subtitle: Visibility(
                  visible: categorie == "P",
                  child: Text(
                    data[val]["loseSide"] ?? "RAS",
                    style: const TextStyle(
                      color: recovaColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Divider(
                height: 5,
                color: recovaColor,
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MyCustomPageAnimationTransition(
            SecondePage(
              key: UniqueKey(),
              recover_object_id: val,
              ojectList: data,
            ),
          ));

          // Navigator.of(context).push(route)

          // var route = MaterialPageRoute(
          //   builder: (BuildContext context) => SecondePage(
          //     key: UniqueKey(),
          //     recover_object_id: val, ojectList: data,
          //   ),
          // );
          // Navigator.of(context).push(route);
        },
      );
    }

    return Scrollbar(
      key: PageStorageKey<String>("gogo${data.hashCode}"),
      child: ListView.builder(
        // key: pageStorageKey,
        key: pageStorageKey,
        reverse: true,
        // key: PageStorageKey<String>("didi${data.hashCode}"),
        itemCount: data.isEmpty ? 0 : data.length,
        itemBuilder: (context, val) {
          IconData icon = Icons.adb_outlined;
          switch (objectIdToName[(data[val]["objectType"])]) {
            case "CNI":
              icon = Icons.credit_card_sharp;
              break;
            case "VISA":
              icon = Icons.call_to_action_rounded;
              break;
            case "Passport":
              icon = Icons.book_outlined;
              break;
            case "Permis de conduire":
              icon = Icons.book_outlined;
              break;
            case "Acte de naissance":
              icon = Icons.folder_shared_outlined;
              break;
            case "Diplôme":
              icon = Icons.school_outlined;
              break;
            case "Enfant":
              icon = Icons.person;
              break;
          }
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ownItemToDisplays(val, icon),
            ],
          );
        },
      ),
    );
  }
}

class MyCustomPageAnimationTransition extends PageRouteBuilder {
  final Widget enterWidget;
  MyCustomPageAnimationTransition(this.enterWidget)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                enterWidget,
            transitionDuration: const Duration(milliseconds: 1500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return ScaleTransition(
                scale: animation,
                alignment: const Alignment(0.0, 0.0),
                child: child,
              );
            });
}
