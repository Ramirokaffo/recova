import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'package:im_stepper/stepper.dart';

import 'RoutesFile.dart';

class UserTransactionPage extends StatefulWidget {
  const UserTransactionPage({Key? key}) : super(key: key);

  @override
  _UserTransactionPageState createState() => _UserTransactionPageState();
}

class _UserTransactionPageState extends State<UserTransactionPage> {
  String? objectTypeController;
  TextEditingController newObjectTypeController = TextEditingController();
  bool isOpen = false;
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  int activeStep = 3; // Initial step set to 5.
  int upperBound = 7; // upperBound MUST BE total number of icons minus 1.

  // void showSnackBar(String message) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

  void show(BuildContext context, Widget Function(BuildContext) build) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: build);

    overlayState?.insert(overlayEntry);

    await Future.delayed(const Duration(seconds: 2));

    overlayEntry.remove();
  }

  Widget _build(BuildContext context) {
    return Positioned(
      top: 50.0,
      left: 50.0,
      child: Material(
        color: Colors.transparent,
        child: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.warning, color: Colors.purple)),
      ),
    );
  }

  @override
  void initState() {
    newGetAllObjectType();
    () async {
      if (oneUserDataDico.isEmpty) {
        await getOneUserDataById();
      }
    }();
    super.initState();
  }

  void deleteTransaction(BuildContext context, int id, String categorie) async {
    showSimpleDialog(
        title: "Attention",
        context: context,
        message: "Êtes-vous sûr de vouloir supprimer cet élément ?",
        isimgvisible: true,
        actionText: "Oui",
        onActionTap: () async {
          var status =
              await userDeleteOwnTransaction(id: id, categorie: categorie);
          // print(status);
          if (status["status"] == "yes") {
            showSimpleSnackbar(
                rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                message: "Transaction supprimée avec succès !",
                context: context);
            setState(() {});
          } else {
            showSimpleSnackbar(
                rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                message: "Une erreur est survenue lors de la suppression !",
                context: context);
          }
        });
    // return;
  }

  Widget oneTransactionToShow(
      Map data, IconData? icon, String trailing, Color color, Function onTap,
      {required Null Function() onMoreTape}) {
    return InkWell(
      onTap: () {
        onMoreTape();
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Material(
              borderRadius: BorderRadiusDirectional.circular(5),
              elevation: 3,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Hero(
                            tag: data["id"],
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (context, error, stackTrace) {
                                print(error);
                                return const Icon(
                                  Icons.book,
                                  color: Colors.white,
                                );
                              },
                              placeholder: placeholder,
                              image: data["image"],
                            ),
                          ),
                        ),
                        onTap: () {
                          var route = PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    DisplaysImage(
                              key: UniqueKey(),
                              image: data["image"],
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              animation = CurvedAnimation(
                                  curve: Curves.easeIn, parent: animation);
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          );
                          Navigator.of(context).push(route);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              data["typeName"]! != "Autres"
                                  ? data["typeName"]!
                                  : data["otherType"],
                              style: const TextStyle(
                                  color: recovaColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            data["nowSide"] != null ? "${data["holderId"] == oneUserDataDico["id"]? "Vous avez": "Un utilisateur a" } retrouvé" :
                            "${data["OwnerId"] == oneUserDataDico["id"]? "Vous avez": "Un utilisateur a"} perdu",
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: icon != null
                          ? Icon(
                              icon,
                              color: color,
                              shadows: const [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    blurStyle: BlurStyle.inner)
                              ],
                            )
                          : const SizedBox(
                              height: 0.1,
                            ),
                    ),
                    Expanded(
                        flex: 3,
                        child: InkWell(
                          child: Material(
                            shadowColor: Colors.black,
                            elevation: 3,
                            borderRadius: BorderRadius.circular(10),
                            color: recovaColor,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[Colors.purpleAccent, recovaColor],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                (trailing == "Nothing"
                                    ? "Supprimer"
                                    : trailing),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          onTap: () {
                            onTap();
                          },
                        )),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget onePendingTransactionToShow(Map data, String texte,
      String buttonText, Color color, Function onTap,
      {String leadingText = "Supprimer",
      String trailing = "Plus",
      required Function onMoreTape}) {
    Widget oneButton(String texte, Function onTap, {bool isprincipal = false}) {
      return Material(
        elevation: 4,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        type: MaterialType.card,
        borderOnForeground: false,
        color: isprincipal ? recovaColor : Colors.white54,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          overlayColor: MaterialStateColor.resolveWith((states) => recovaColor),
          focusColor: recovaColor,
          splashColor: recovaColor,
          highlightColor: recovaColor,
          hoverColor: recovaColor,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            // width: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  recovaColor.withRed(180),
                  recovaColor.withOpacity(1),
                  // Color(0xff0498f8),
                  // recovaColor.withOpacity(0.5),
                ],
                // begin: const FractionalOffset(0.0, 0.5),
                end: Alignment.bottomLeft,
                // stops: const [0.0, 5.9],
                // tileMode: TileMode.mirror,
              ),

              // color: isprincipal ? recovaColor : Colors.black12,
              borderRadius: BorderRadius.circular(8),
              // border: const Border(top: BorderSide(color: recovaColor, width: 0.5), bottom: BorderSide(color: recovaColor, width: 0.5,), left: BorderSide(color: recovaColor, width: 0.5,), right: BorderSide(color: recovaColor, width: 0.5,))
            ),
            child: Text(
              texte,
              style: TextStyle(
                  color: isprincipal ? Colors.white : Colors.black,
                  fontWeight:
                      isprincipal ? FontWeight.bold : FontWeight.normal),
            ),
          ),
          onTap: () {
            onTap();
          },
        ),
      );
    }

    return Material(
      elevation: 10,
        borderRadius: BorderRadius.circular(10),
      color: recovaColor,

    child: InkWell(
        onTap: (){
          onMoreTape();
        },
        child: Stack(
          children: [
            Container(
            // padding: const EdgeInsets.only(bottom: 5),

            // width: 25,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                // color: recovaColor.withOpacity(0.5),
                // gradient: LinearGradient(
                //   colors: [
                //     recovaColor.withRed(180),
                //     recovaColor.withOpacity(1),
                //     // Color(0xff0498f8),
                //     // recovaColor.withOpacity(0.5),
                //   ],
                //   begin: const FractionalOffset(0.0, 0.5),
                //   end: Alignment.topLeft,
                //   stops: const [0.0, 5.9],
                //   tileMode: TileMode.mirror,
                // ),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(

                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7),

                  ),
                  child: Text(
                    texte,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // oneButton(leadingText, onTap),
                    Visibility(
                      maintainInteractivity: false,
                        maintainSize: false,
                        maintainState: false,
                        visible: buttonText != "Nothing",
                        child: oneButton(buttonText, onTap, isprincipal: true)),
                    // oneButton(trailing, onMoreTape),
                  ],
                )
              ],
            ),
          ),
            Positioned(
                top: -12,
              right: -10,
                child: IconButton(onPressed: (){
                  onMoreTape();
                },
                    icon: const Icon(Icons.more_horiz, color: Colors.white,)),
            ),
          ]
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onMoreTap(
        Map<dynamic, dynamic> data, String firstText, String secondText) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (context) {
          var listpath = data["proofImage"].toString().split("/");
          return Container(
            height: MediaQuery.of(context).size.height * 15 / 16,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: recovaColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        CloseButton(
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 34,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: recovaColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.contain,
                                width: double.infinity,
                                placeholder: placeholder,
                                image: data["image"],
                              ),
                              onTap: () {
                                var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DisplaysImage(
                                    key: UniqueKey(),
                                    image: data["image"],
                                  ),
                                );
                                Navigator.of(context).push(route);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          child: Text(firstText),
                        ),
                        Visibility(
                          visible: data["proofImage"] != null,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      image:
                                          "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/PR",
                                      placeholder: placeholder,
                                    ),
                                    onTap: () {
                                      var route = MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            DisplaysImage(
                                          key: UniqueKey(),
                                          image: "http://$uri/object/getOneImgObject/${listpath[listpath.length - 1]}/PR",
                                        ),
                                      );
                                      Navigator.of(context).push(route);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                child: Text(secondText,
                                    style: const TextStyle(
                                        // fontSize: 20,
                                        // fontWeight: FontWeight.bold,
                                        // color: recovaColor
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget oneTapBarToShow(String categorie, String dif) {
      // PageController controller = PageController();

      Widget notPendingTransactionWidget() {
        return Center(
          child: Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: recovaColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              // boxShadow: [BoxShadow(blurRadius: 1)]
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child: CircleAvatar(
                      backgroundColor: recovaColor.withOpacity(0.3),
                        child: Icon(Icons.info_outline, color: recovaColor,))),
                const Expanded(
                  flex: 6,
                  child: Text("Vous n'avez aucune transaction en attente de validation ou de paiement",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify, ),
                ),
              ],
            ),
          ),
        );
      }
      Widget anyTransactionWidget(String categorie) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
              // boxShadow: [BoxShadow(blurRadius: 1)]
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
              backgroundColor: recovaColor.withOpacity(0.1),
            child: const CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.info_outline_rounded, color: recovaColor),),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // margin: EdgeInsets.symmetric(vertical: 30),
                    child: Text(categorie == "R"? "Vous n'avez déclaré aucun objet retrouvé": "Vous n'avez déclaré aucun objet perdu",
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (dif == "N") {
                return Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white.withOpacity(0.2),
                    //   borderRadius: BorderRadius.circular(5)
                    //   // gradient: LinearGradient(
                    //   //   colors: [
                    //   //     recovaColor.withRed(180),
                    //   //     recovaColor.withOpacity(1),
                    //   //   ],
                    //   //   begin: const FractionalOffset(0.0, 0.8),
                    //   //   end: Alignment.topCenter,
                    //   //   stops: const [0.0, 5.9],
                    //   //   tileMode: TileMode.clamp,
                    //   // ),
                    // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.05),
                        //     borderRadius: BorderRadius.circular(5),),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: recovaColor.withRed(100),
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(5),),
                              child: ListTile(
                                title: Text(
                                  'Erreur veuillez vérifier votre connexion internet et reessayer',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.5),
                                  child: Icon(Icons.info_outline_rounded, color: recovaColor,),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("images/8516dec954b578b3b15def9f672e9930.jpg", scale: 4,),
                    const Text(
                      'Veuillez vérifier votre connexion internet et reéssayer',
                      style: TextStyle(fontSize: 18, color: recovaColor),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: recovaColor,
                      ),
                    ),
                  ],
                );
              }

            } else if (snapshot.hasData) {
              final data = snapshot.data as List;
              if (data.isNotEmpty) {
                () async {if (oneUserDataDico.isEmpty) {
                  await getOneUserDataById();
                }}();
                List analyseFunction(Map<String, dynamic> data) {
                  String pendingTransactionText =
                      "${oneUserDataDico["fullname"]}, "
                      "votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} a déjà été retrouvé";
                  String buttonText = "Nothing";
                  IconData? icon = Icons.check_circle_rounded;
                  Color color = Colors.green;
                  String firstText = "Image de recherche";
                  String secondText = "Image de l'élément retrouvé";
                  // print(data);

                  // showFooterActionSelectMoyenRcouvrement(context, objectId)
                  Function function = () {
                    deleteTransaction(context, data["id"], categorie);

                  };
                  if (data["objectStatus"] == "NR" &&
                      data["OwnerId"] == oneUserDataDico["id"] &&
                      data["categorie"] == "P") {
                    icon = Icons
                        .more_horiz; // Tu as declaré que l'objet est perdu mais personne n'a remarqué
                    color = Colors.black;
                    firstText =
                        "Ceci est l'image que vous avez envoyé pour déclarer la perte de votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]}";
                  } else if (data["objectStatus"] == "NR" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["categorie"] == "R") {
                    // print(data);

                    icon = Icons
                        .more_horiz; // Tu as declaré que l'objet est retrouvé mais personne n'a remarqué
                    color = Colors.black;
                    firstText =
                        "Ceci est l'image de l'élément que vous avez retrouvé";
                    // print("ici la");
                  } else if (data["objectStatus"] == "R" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["categorie"] == "P") {
                    // buttonText = "Plus"; // Tu as remarqué(retrouvé) un objet qui a été declaré perdu et le proprietaire doit avoir été notifié
                    color = Colors.orange;
                    firstText =
                        "Ceci est l'image de l'élément qui a été déclaré perdu";
                    pendingTransactionText = "${oneUserDataDico["fullname"]}, "
                        "le proprietaire de [${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]}] a été alerté, une fois qu'il aura déposé vos frais, vous serez alerté !";

                  } else if (data["objectStatus"] == "R" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["categorie"] == "R") {
                    print(data);
                    // buttonText =
                    // color = Colors.red;
                    color = Colors.orange;
                    firstText =
                    "Ceci est l'image de l'élément qui a été retrouvé";
                    pendingTransactionText = "${oneUserDataDico["fullname"]}, "
                        "le proprietaire de [${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]}] a été alerté, une fois qu'il aura déposé vos frais, vous serez notifié ! \n\n"
                        "RECOVA vous remercie !";

                    // firstText =
                    //     "Ceci est l'image de votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} égaré qui a été retrouvé";
                    //
                    // pendingTransactionText = "${oneUserDataDico["fullname"]}, "
                    //     "vous devez payer des frais pour votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} qui a été retrouvé pour entrer en possession";
                    // function = () {
                    //   showFooterActionSelectMoyenRcouvrement(
                    //       context, data["id"]);};
                  } else if (data["objectStatus"] == "EC" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["categorie"] == "P") {
                    // buttonText = "Nothing"; // Impossible pour le moment
                    icon = Icons.more_horiz;
                  } else if (data["objectStatus"] == "EC" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["categorie"] == "R") {
                    buttonText =
                        "Confirmer"; // Tu as remarqué ton objet qui a été déclaré retrouvé par quelqu'un, tu as deja payé mais pas encore entré en possession
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} égaré qui a été retrouvé dans la region de(du): ${data["nowSide"]}";

                    pendingTransactionText =
                        "${oneUserDataDico["fullname"]}, si vous êtes déjà entrés en possession de"
                        "votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} veuillez confirmer pour qu'on puisse payer celui qui a retrouvé !";
                    // pendingTransactionText = "Chèr(e) ${oneUserDataDico["fullname"]}, une fois que vous entrez en possession de"
                    //     "votre ${objectIdToName[data["objectType"]] != "Autres"?
                    // objectIdToName[data["objectType"]]: data["otherType"] } nous vous prions de revenir confirmer pour qu'on puisse payer celui qui a retrouvé !";
                  } else if (data["objectStatus"] == "EC" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["categorie"] == "P") {
                    buttonText =
                        "Confirmer"; // Quelqu'un a retrouvé ton objet que tu as declaré perdu et tu as deja payé mais pas recu
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} égaré qui a été retrouvé dans la region de(du): ${data["nowSide"]}";

                    pendingTransactionText =
                        "${oneUserDataDico["fullname"]}, si vous êtes déjà entrés en possession de"
                        "votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} veuillez confirmer pour qu'on puisse payer celui qui a retrouvé !";
                  } else if (data["objectStatus"] == "EC" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["categorie"] == "R") {
                    buttonText =
                        'Son contact'; // Tu as déclaré avoir retrouvé un objet et le proprietaire a deja payé mais sans entrer en possession
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de l'élément que vous avez retrouvé";

                    pendingTransactionText =
                        "Chèr(e) ${oneUserDataDico["fullname"]}, votre contact a été envoyé au propriétaire de"
                        "${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} donc vous pouvez recevoir son coup de fil d'un moment à l'autre !";
                  } else if (data["objectStatus"] == "R" &&
                      data["OwnerId"] == oneUserDataDico["id"] &&
                      data["categorie"] != "P") {
                    buttonText =
                    "Payer"; // On a remarqué ton objet qui a été déclaré perdu mais tu n'as pas encore payé
                    color = Colors.red;
                    firstText =
                    "Ceci est l'image de votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} égaré qui a été retrouvé";

                    pendingTransactionText = "${oneUserDataDico["fullname"]}, "
                        "vous devez payer des frais pour votre ${data["typeName"] != "Autres"? data["typeName"]: data["otherType"]} qui a été retrouvé pour entrer en possession";
                    function = () {
                      showFooterActionSelectMoyenRcouvrement(
                          context, data["id"]);};
                  } else {
                    // icon = null;
                    print(data);
                  }
                  return [
                    firstText,
                    buttonText,
                    pendingTransactionText,
                    icon,
                    function,
                    color,
                    secondText
                  ];
                }

                if (dif == "N") {
                  return Scrollbar(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          List liste = analyseFunction(data[index]);
                          String firstText = liste[0];
                          String secondText = liste[6];
                          String trailing = liste[1];
                          // String pendingTransactionText = liste[2];
                          IconData icon = liste[3];
                          Function function = liste[4];
                          Color color = liste[5];
                          return oneTransactionToShow(
                              data[index], icon, trailing, color, () {
                            function();
                          }, onMoreTape: () {
                            onMoreTap(data[index], firstText, secondText);
                          },);
                        }),
                  );
                } else {
                  PageController controller = PageController();
                  // print(data);
                  return ListView.builder(
                      controller: controller,
                      // padding: EdgeInsets.all(5),
                      itemCount: data.length,
                      // allowImplicitScrolling: false,
                      scrollDirection: data.length != 1? Axis.horizontal: Axis.vertical,
                      // pageSnapping: false,
                      // padEnds: false,
                      // physics: ScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      // reverse: true,
                      itemBuilder: (BuildContext context, int ind) {
                        List liste = analyseFunction(data[ind]);
                        String firstText = liste[0];
                        String buttonText = liste[1];
                        String secondText = liste[6];
                        String pendingTransactionText = liste[2];
                        // IconData icon = liste[3];
                        Function function = liste[4];
                        Color color = liste[5];
                        if (data.length == 1) {
                          return Container(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: 260,
                            height: 150,
                            child: onePendingTransactionToShow(
                              data[ind],
                              // icon,
                              pendingTransactionText,
                              buttonText,
                              color,
                              () {
                                function();
                              },
                              onMoreTape: () {
                                onMoreTap(data[ind], firstText, secondText);
                              },
                            ),
                          ),
                        );
                        } else {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: 260,
                              child: onePendingTransactionToShow(
                                data[ind],
                                // icon,
                                pendingTransactionText,
                                buttonText,
                                color,
                                    () {
                                  function();
                                },
                                onMoreTape: () {
                                  onMoreTap(data[ind], firstText, secondText);
                                },
                              ),
                            ),
                          );

                        }
                      });
                }

                // return Scrollbar(
                //     // controller: controller,
                //     child: (dif != "N" ? PageView.builder : ListView.builder) (
                //   // controller: dif != "N"?controller: null,
                //   itemCount: data.length,
                //         // padEnds: false,
                //   itemBuilder: (BuildContext context, int index) {
                //     // print(data); List<dynamic>
                //     analyseFunction(data[index]);
                //
                //
                //     if (dif == "N") {
                //       return oneTransactionToShow(
                //           data[index], icon, trailing, color, () {
                //         function(context, data[index]["id"]);
                //       });
                //     } else {
                //       return FittedBox(
                //         fit: BoxFit.contain,
                //         child: SizedBox(
                //           width: 280,
                //           // height: 100,
                //           child: onePendingTransactionToShow(data[index], icon,
                //               pendingTransactionText, trailing, color, () {
                //             function(context, data[index]["id"]);
                //           }, onMoreTape: () {}),
                //         ),
                //       );
                //     }
                //   },
                // ));
              } else {
                if (dif == "N") {
                  if (categorie == "R") {
                    return anyTransactionWidget(categorie);
                  } else {
                    return anyTransactionWidget(categorie);
                  }
                } else {
                  return notPendingTransactionWidget();
                }
              }
            }
          }

          return transitionWidget2(color: dif == "N"? Colors.white: recovaColor);
        },
        future: (dif == "N")
            ? userGetOnwerObjectTransaction(categorie)
            : userGetPendingTransaction("A"),
      );





      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (dif == "N") {
                return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          recovaColor.withRed(180),
                          recovaColor.withOpacity(1),
                        ],
                        begin: const FractionalOffset(0.0, 0.8),
                        end: Alignment.topCenter,
                        stops: const [0.0, 5.9],
                        tileMode: TileMode.clamp,
                      ),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Erreur veuillez vérifier votre connexion internet et reessayer',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset("images/8516dec954b578b3b15def9f672e9930.jpg", scale: 4,),
                    const Text(
                      'Veuillez vérifier votre connexion internet et reéssayer',
                      style: TextStyle(fontSize: 18, color: recovaColor),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: recovaColor,
                      ),
                    ),
                  ],
                );
              }

            } else if (snapshot.hasData) {
              final data = snapshot.data as List;
              if (data.isNotEmpty) {
                List analyseFunction(Map<String, dynamic> data) {
                  String pendingTransactionText =
                      "${oneUserDataDico["fullname"]}, "
                      "votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} a déjà été retrouvé";
                  String buttonText = "Nothing";
                  IconData? icon = Icons.check_circle_rounded;
                  Color color = Colors.green;
                  String firstText = "Image de recherche";
                  String secondText = "Image de l'élément retrouvé";
                  // showFooterActionSelectMoyenRcouvrement(context, objectId)
                  Function function = () {
                    deleteTransaction(context, data["id"], categorie);
                  };

                  if (data["objectStatus"] == "NR" &&
                      data["OwnerId"] == oneUserDataDico["id"] &&
                      data["loseSide"] != null) {
                    icon = Icons
                        .more_horiz; // Tu as declaré que l'objet est perdu mais personne n'a remarqué
                    color = Colors.black;
                    firstText =
                        "Ceci est l'image que vous avez envoyé pour déclarer la perte de votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]}";
                  } else if (data["objectStatus"] == "NR" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["nowSide"] != null) {
                    icon = Icons
                        .more_horiz; // Tu as declaré que l'objet est retrouvé mais personne n'a remarqué
                    color = Colors.black;
                    firstText =
                        "Ceci est l'image de l'élément que vous avez retrouvé";
                    print("ici la");
                  } else if (data["objectStatus"] == "R" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["loseSide"] != null) {
                    // buttonText = "Plus"; // Tu as remarqué(retrouvé) un objet qui a été declaré perdu et le proprietaire doit avoir été notifié
                    color = Colors.orange;
                    firstText =
                        "Ceci est l'image de l'élément qui a été déclaré perdu";
                  } else if (data["objectStatus"] == "R" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["nowSide"] != null) {
                    buttonText =
                        "Payer"; // Tu as remarqué ton objet qui a été déclaré retrouvé par quelqu'un mais tu n'as pas encore payé
                    color = Colors.red;
                    firstText =
                        "Ceci est l'image de votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} égaré qui a été retrouvé dans la region de(du): ${data["nowSide"]}";

                    pendingTransactionText = "${oneUserDataDico["fullname"]}, "
                        "vous devez payer des frais pour votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} qui a été retrouvé pour entrer en possession";
                    function = () {
                      showFooterActionSelectMoyenRcouvrement(
                          context, data["id"]);};
                  } else if (data["objectStatus"] == "EC" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["loseSide"] != null) {
                    // buttonText = "Nothing"; // Impossible pour le moment
                    icon = Icons.more_horiz;
                    // print(data);
                  } else if (data["objectStatus"] == "EC" &&
                      data["userRemarqueObject"] == oneUserDataDico["id"] &&
                      data["nowSide"] != null) {
                    buttonText =
                        "Confirmer"; // Tu as remarqué ton objet qui a été déclaré retrouvé par quelqu'un, tu as deja payé mais pas encore entré en possession
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} égaré qui a été retrouvé dans la region de(du): ${data["nowSide"]}";

                    pendingTransactionText =
                        "${oneUserDataDico["fullname"]}, si vous êtes déjà entrés en possession de"
                        "votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} veuillez confirmer pour qu'on puisse payer celui qui a retrouvé !";
                    // pendingTransactionText = "Chèr(e) ${oneUserDataDico["fullname"]}, une fois que vous entrez en possession de"
                    //     "votre ${objectIdToName[data["objectType"]] != "Autres"?
                    // objectIdToName[data["objectType"]]: data["otherType"] } nous vous prions de revenir confirmer pour qu'on puisse payer celui qui a retrouvé !";
                  } else if (data["objectStatus"] == "EC" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["loseSide"] != null) {
                    buttonText =
                        "Confirmer"; // Quelqu'un a retrouvé ton objet que tu as declaré perdu et tu as deja payé mais pas recu
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} égaré qui a été retrouvé dans la region de(du): ${data["nowSide"]}";

                    pendingTransactionText =
                        "${oneUserDataDico["fullname"]}, si vous êtes déjà entrés en possession de"
                        "votre ${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} veuillez confirmer pour qu'on puisse payer celui qui a retrouvé !";
                  } else if (data["objectStatus"] == "EC" &&
                      data["holderId"] == oneUserDataDico["id"] &&
                      data["nowSide"] != null) {
                    buttonText =
                        'Son contact'; // Tu as déclaré avoir retrouvé un objet et le proprietaire a deja payé mais sans entrer en possession
                    icon = Icons.more_horiz;
                    firstText =
                        "Ceci est l'image de l'élément que vous avez retrouvé";

                    pendingTransactionText =
                        "Chèr(e) ${oneUserDataDico["fullname"]}, votre contact a été envoyé au propriétaire de"
                        "${objectIdToName[data["objectType"]] != "Autres" ? objectIdToName[data["objectType"]] : data["otherType"]} donc vous pouvez recevoir son coup de fil d'un moment à l'autre !";
                  } else {
                    icon = null;
                    print(data);
                  }
                  return [
                    firstText,
                    buttonText,
                    pendingTransactionText,
                    icon,
                    function,
                    color,
                    secondText
                  ];
                }

                if (dif == "N") {
                  return Scrollbar(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(data[index]);
                          List liste = analyseFunction(data[index]);
                          String firstText = liste[0];
                          String secondText = liste[6];
                          String trailing = liste[1];
                          String pendingTransactionText = liste[2];
                          IconData icon = liste[3];
                          Function function = liste[4];
                          Color color = liste[5];
                          return oneTransactionToShow(
                              data[index], icon, trailing, color, () {
                            function();
                          }, onMoreTape: () {
                            onMoreTap(data[index], firstText, secondText);
                          },);
                        }),
                  );
                } else {
                  PageController controller = PageController();
                  return ListView.builder(
                      controller: controller,
                      // padding: EdgeInsets.all(5),
                      itemCount: data.length,
                      // allowImplicitScrolling: false,
                      scrollDirection: Axis.horizontal,
                      // pageSnapping: false,
                      // padEnds: false,
                      // physics: ScrollPhysics(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      // reverse: true,
                      itemBuilder: (BuildContext context, int ind) {
                        List liste = analyseFunction(data[ind]);
                        String firstText = liste[0];
                        String buttonText = liste[1];
                        String secondText = liste[6];
                        String pendingTransactionText = liste[2];
                        IconData icon = liste[3];
                        Function function = liste[4];
                        Color color = liste[5];
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: 260,
                            child: onePendingTransactionToShow(
                              data[ind],
                              // icon,
                              pendingTransactionText,
                              buttonText,
                              color,
                              () {
                                function();
                              },
                              onMoreTape: () {
                                onMoreTap(data[ind], firstText, secondText);
                              },
                            ),
                          ),
                        );
                      });
                }

                // return Scrollbar(
                //     // controller: controller,
                //     child: (dif != "N" ? PageView.builder : ListView.builder) (
                //   // controller: dif != "N"?controller: null,
                //   itemCount: data.length,
                //         // padEnds: false,
                //   itemBuilder: (BuildContext context, int index) {
                //     // print(data); List<dynamic>
                //     analyseFunction(data[index]);
                //
                //
                //     if (dif == "N") {
                //       return oneTransactionToShow(
                //           data[index], icon, trailing, color, () {
                //         function(context, data[index]["id"]);
                //       });
                //     } else {
                //       return FittedBox(
                //         fit: BoxFit.contain,
                //         child: SizedBox(
                //           width: 280,
                //           // height: 100,
                //           child: onePendingTransactionToShow(data[index], icon,
                //               pendingTransactionText, trailing, color, () {
                //             function(context, data[index]["id"]);
                //           }, onMoreTape: () {}),
                //         ),
                //       );
                //     }
                //   },
                // ));
              } else {
                if (dif == "N") {
                  return anyTransactionWidget(categorie);
                } else {
                  return notPendingTransactionWidget();
                }
              }
            }
          }
          return transitionWidget2();
        },
        future: (dif == "N")
            ? userGetOnwerObjectTransaction(categorie)
            : userGetPendingTransaction("A"),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   // scrolledUnderElevation: 100,
        //   centerTitle: true,
        //   toolbarHeight: 40,
        //   // actions: [
        //   //   IconButton(
        //   //       onPressed: () {
        //   //         show(context, _build);
        //   //         // Navigator.of(context).pushNamed("IconStepperDemos");
        //   //       },
        //   //       icon: const Icon(Icons.add_box))
        //   // ],
        //   title: const Text(
        //     "Mes transactions",
        //     style: TextStyle(
        //         color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: recovaColor,
        //   // leading: IconButton(
        //   //     onPressed: () {
        //   //       Navigator.of(context).pop();
        //   //     },
        //   //     icon: const Icon(
        //   //       Icons.arrow_back_ios,
        //   //       color: Colors.white,
        //   //     )),
        // ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Container(child: oneTapBarToShow("R", "E"))),
                      // Expanded(
                      //   flex: 1,
                      //   child: DotStepper(
                      //     fixedDotDecoration:
                      //         const FixedDotDecoration(
                      //             color: recovaColor),
                      //     indicatorDecoration:
                      //         const IndicatorDecoration(
                      //             color: Colors.blue,
                      //             strokeColor: Colors.blue),
                      //     dotCount: upperBound,
                      //     dotRadius: 18,
                      //     shape: Shape.pipe,
                      //     spacing: 10,
                      //     activeStep: activeStep,
                      //     onDotTapped: (index) {
                      //       setState(() {
                      //         activeStep = index;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                )),
            const Divider(
              color: recovaColor,
            ),
            Expanded(
              flex: 5,
              child: DefaultTabController(
                length: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: recovaColor.withBlue(200),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     recovaColor.withRed(180),
                    //     recovaColor.withBlue(250),
                    //   ],
                    //   begin: const FractionalOffset(0.0, 0.8),
                    //   end: Alignment.topCenter,
                    //   stops: const [0.0, 5.9],
                    //   transform: const GradientRotation(180),
                    //   tileMode: TileMode.clamp,
                    // ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TabBar(indicatorColor: recovaColor.withRed(180), tabs: const [
                          Tab(
                            child: Text(
                              "Retrouvé",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Perdu",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                      ),
                      Expanded(
                        flex: 12,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 0, left: 5, right: 5),
                          child: TabBarView(children: [
                            oneTapBarToShow("R", "N"),
                            oneTapBarToShow("P", "N"),
                          ]),

                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: <Widget>[
                          //     const SizedBox(height: 10,),
                          //     oneTransactionToShow({}, Icons.check_circle_rounded, "Supprimer", Colors.green, (){}),
                          //     oneTransactionToShow({}, Icons.more_horiz, "Valider", Colors.orange, (){}),
                          //   ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buttonInfo(String text, Function onTap, BuildContext context) {
  return Material(
    borderRadius: BorderRadius.circular(25),
    color: recovaColor,
    elevation: 4.0,
    shadowColor: Colors.black,
    child: InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ),
  );
}
