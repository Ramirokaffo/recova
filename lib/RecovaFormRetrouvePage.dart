import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';

class RecovaRecoverThingForm extends StatefulWidget {
  const RecovaRecoverThingForm({Key? key}) : super(key: key);

  @override
  _RecovaRecoverThingFormState createState() => _RecovaRecoverThingFormState();
}

class _RecovaRecoverThingFormState extends State<RecovaRecoverThingForm> {
  // String recoverDate = DateTime.now().toString();
  List<DropdownMenuItem<String>> ListObjectType = [];
  TextEditingController idObjectController = TextEditingController();
  TextEditingController objectTypeController = TextEditingController();
  TextEditingController ownerObjectController = TextEditingController();
  TextEditingController loseSideObjectController = TextEditingController();
  TextEditingController objectDescriptionController = TextEditingController();
  TextEditingController contactOwnerObjectController =
      TextEditingController(text: oneUserDataDico["telephone"].toString().isNotEmpty? oneUserDataDico["telephone"]: oneUserDataDico["telephone2"]);
  List<Widget> formPerduList = [];
  bool isLoading = true;



  void validateRecoverObject() async {
    if (objectImageData["path"] == "" || objectImageData["name"] == "") {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "La photo est obligatoire !",
          context: context);
      return;
    } else if (objectTypeController == null) {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "Vous n'avez pas choisi le type d'objet !",
          context: context);
      return;
    } else if (loseSideObjectController.text.isEmpty ||
        contactOwnerObjectController.text.isEmpty ||
        idObjectController.text.isEmpty ||
        ownerObjectController.text.isEmpty) {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
              "L'identifiant, le nom, votre position et votre contact sont obigatoires !",
          context: context);
      return;
    }
    waitSendingDataWidget(context);

    var status = await sendRecoverOrLoseThingData(
        imagesPath: objectImageData["path"],
        imageName: objectImageData["name"],
        objectType: objectTypeController.text,
        categorie: "R",
        loseOrNowSide: loseSideObjectController.text,
        holderLoseOrOwnerNumber: contactOwnerObjectController.text,
        objectNumber: idObjectController.text,
        objectOrOwnerName: ownerObjectController.text,
        objectDescription: objectDescriptionController.text);
    print("voici status: $status");
    // return;
    if (status["status"] == "yes") {
      Navigator.of(context).pop();
      // loseSideObjectController.clear();
      // idObjectController.clear();
      // objectDescriptionController.clear();
      // objectImageData["path"] = "";
      // objectImageData["name"] = "";
      if (status["data"] != "none") {
        // Navigator.of(context).pop();
        var route = MaterialPageRoute(
          builder: (BuildContext context) => InitialSearchPage(
            key: UniqueKey(),
            data: status["data"],
          ),
        );
        Navigator.of(context).push(route);
      } else {
        // Navigator.of(context).pop();
        showSimpleSnackbar(
            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
            message: "L'objet a été publié avec succès",
            context: context);
        // Timer(Duration(seconds: 2), () {
        //   Navigator.of(context).pop();
        // });

      }
    } else {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
              "Une erreur est survenue lors de la publication; Veuillez réessayer !",
          context: context);
    }
  }

  Future pendingFunction() async {
    try {
      await newGetAllObjectType();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      Navigator.pop(context);
      showSimpleDialog(title: "RECOVA", context: context, message: "Une erreur s'est produite");
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    if (isLoading) {
      pendingFunction();
    }
    super.initState();
  }


  void refreshParentState(BuildContext context) {
    setState(() {
    });}

  @override
  void dispose() {
    contactOwnerObjectController.dispose();
    objectDescriptionController.dispose();
    ownerObjectController.dispose();
    loseSideObjectController.dispose();
    idObjectController.dispose();
    objectImageData["name"] = "";
    objectImageData["path"] = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    formPerduList.clear();
    formPerduList.addAll([
      const SizedBox(
        height: 10,
      ),
      typeWidget(objectTypeController, showDropDownListTypeObject, context),

      const SizedBox(
        height: 30,
      ),
      idWidget(idObjectController),
      const SizedBox(
        height: 10,
      ),
      nameWiget(ownerObjectController, "Saisissez le nom complet écrit sur l'objet"),
      const SizedBox(
        height: 10,
      ),

      sideWidget(loseSideObjectController, "Votre localisation", context),
      const SizedBox(
        height: 10,
      ),
      contactWidget(contactOwnerObjectController),
      const SizedBox(
        height: 10,
      ),
      descriptionWidget(objectDescriptionController, "Décrivez l'objet ou les circonstances dans lesquelles vous l'avez retrouvé"),
      // const SizedBox(
      //   height: 10,
      // ),
      // dateWidget(selectRecoverOrLoseDate, context, "Date de recouvrement", refreshParentState),
      const SizedBox(
        height: 20,
      ),
      const Text(
        "Image:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      addImageLine(showFooterActionImagePerduChoice: showFooterActionImagePerduChoice,
        context: context, refreshParentState: refreshParentState, listWidget: formPerduList,),
    ]);
    if (objectImageData["path"]!.isNotEmpty) {
      formPerduList.removeAt(14);
      formPerduList.insert(14, ShowChoiceImage(context: context,
        listWidget: formPerduList, refreshParentState: refreshParentState,));
    }

    return isLoading? transitionWidget(): MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        key: const PageStorageKey<String>("perdu"),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: recovaColor,
          centerTitle: true,
          // toolbarHeight: 120,
          // bottom: PreferredSize(
          //     preferredSize: const Size.square(50),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: recovaColor.withOpacity(0.1),
          //         borderRadius: BorderRadius.circular(10)
          //       ),
          //       child: Column(
          //         children: const [
          //           Divider(color: Colors.white,),
          //           Text(
          //             "Vous avez retrouvé un objet ? Veuillez remplir le formulaire ci-dessous:",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 15),
          //             textAlign: TextAlign.center,
          //           ),
          //           // SizedBox(
          //           //   height: 20,
          //           // ),
          //           // Text(
          //           //   "Veuillez remplir le formulaire ci-dessous:",
          //           //   style: TextStyle(
          //           //     color: Colors.white,
          //           //   ),
          //           //   textAlign: TextAlign.start,
          //           // ),
          //         ],
          //
          //       ),
          //     )),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                ))
          ],
          title: const Text(
            "Objet retrouvé",
            style: TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 60,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: recovaColor,
            ),
            child: InkWell(
              onTap: () {
                validateRecoverObject();
              },
              splashColor: recovaColor,
              hoverColor: recovaMixColor,
              focusColor: recovaMixColor,
              highlightColor: recovaMixColor,
              child: const Center(
                child: Text(
                  "Envoyer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          key: const PageStorageKey<String>("retrouve"),
          child: Container(
            color: Colors.black.withOpacity(0.05),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                infoObjectPageHead("Vous avez retrouvé un objet ?"),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: formPerduList,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 40,
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
