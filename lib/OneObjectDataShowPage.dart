import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/HomePageListElement.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';





class SecondePage extends StatefulWidget {
  final int recover_object_id;
  // final String categorie;
  final List<dynamic>? ojectList;

  SecondePage({super.key, required this.recover_object_id, this.ojectList});

  @override
  _SecondePage createState() => _SecondePage();
}

class _SecondePage extends State<SecondePage> with TickerProviderStateMixin {
  bool backpressed = true;
  late AnimationController controllerToIncreaseCurve;
  late AnimationController controllerToDecreaseCurve;

  late Animation <double> animationToIncreasingCurve;
  late Animation <double> animationToDecreasingCurve;


  @override
  void initState() {
    super.initState();
    controllerToIncreaseCurve = AnimationController(vsync: this, duration: const Duration(milliseconds: 100), upperBound: 1.3);
    controllerToDecreaseCurve = AnimationController(vsync: this, duration: const Duration(milliseconds: 100), upperBound: 1.3);
    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
        CurvedAnimation(parent: controllerToIncreaseCurve,
            curve: Curves.fastLinearToSlowEaseIn))..addListener(() {setState(() {

    });});
    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
        CurvedAnimation(parent: controllerToDecreaseCurve,
            curve: Curves.fastLinearToSlowEaseIn))..addListener(() {setState(() {

    });});
    controllerToIncreaseCurve.forward();

  }


  @override
  void dispose() {
    super.dispose();
    controllerToIncreaseCurve.dispose();
    controllerToDecreaseCurve.dispose();

  }





  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: widget.recover_object_id.toInt());
    Widget cniOneDataObject({required List<dynamic> dataObject}) {
      bool isImageAvalaible = true;
      return Scaffold(
        bottomNavigationBar: Container(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
          color: recovaColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              height: 30,
              width: MediaQuery.of(context).size.width - 40,
              child: TextButton(
                  onPressed: () async {
                    propertyOrRecoverManager(context, dataObject[0], ((dataObject[0]["nowSide"]) != null)? "R": "P");
                  },
                  child: Text(
                    dataObject[0]["nowSide"] != null
                        ? "C'est ma propriété"
                        : "J'ai retrouvé",
                    style: const TextStyle(color: recovaColor),
                  )),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: ListView(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 15)),
              Text(
                '${objectIdToName[dataObject[0]["objectType"]]! != "Autres"? objectIdToName[dataObject[0]["objectType"]]!: dataObject[0]["otherType"] } ${dataObject[0]["loseSide"] == null ? "retrouvé" : "égaré"}',
                style: const TextStyle(
                    color: recovaColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: dataObject[0]["id"],
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/Curve-Loading.gif",
                      image: dataObject[0]["image"],
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        isImageAvalaible = false;
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            height: 200,
                            child: const Text(
                              "Erreur lors du chargement de l'image...",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                onTap: () {
                  if (isImageAvalaible) {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => DisplaysImage(
                        key: UniqueKey(),
                        image: dataObject[0]["image"],
                      ),
                    );
                    Navigator.of(context).push(route);
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Divider(
                  height: 10,
                  color: recovaColor,
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: recovaColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Visibility(
                        visible: (dataObject[0]["objectNumber"] != null),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Numero: ${dataObject[0]["objectNumber"]}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Nom: ${dataObject[0]["objectName"]}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Lieu: ${(dataObject[0]["loseSide"] != null)? dataObject[0]["loseSide"]: dataObject[0]["nowSide"]}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: (dataObject[0]["objectDescription"] != null),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Détails: ${dataObject[0]["objectDescription"]}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(backpressed == false? animationToIncreasingCurve.value
          :animationToDecreasingCurve.value),

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: recovaColor,
          title: const Text(
            "Détails",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: controller,
          itemCount: widget.ojectList?.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'Erreur veuillez vérifier votre connexion internet et reessayer',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      );
                    // } else if (snapshot.) {
                    } else if (snapshot.hasData) {
                      final dataObject = snapshot.data as List;
                      if (dataObject.isNotEmpty) {
                        print("dataObject: $dataObject");
                        switch (objectIdToName[(dataObject[0]["ObjectType"])]) {
                          case "CNI":
                            {
                              return cniOneDataObject(dataObject: dataObject);
                            }
                          case "VISA":
                            {
                              return cniOneDataObject(dataObject: dataObject);
                            }
                          case "Enfant":
                            {
                              return cniOneDataObject(dataObject: dataObject);
                            }
                          default:
                            {
                              return cniOneDataObject(dataObject: dataObject);
                            }
                        }
                      } else {
                        return const Center(
                          child: Text(
                            "Désolé une erreur s'est produite, veuillez reéssayer !",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                future: selectOwnObjectsById(widget.ojectList![index]["id"], ((widget.ojectList![index]["nowSide"]) != null)? "R": "P"),
              ),
            );
          },
        ),
      ),
    );
  }
}
