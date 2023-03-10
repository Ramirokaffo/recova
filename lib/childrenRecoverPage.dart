import 'package:flutter/material.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';

class RecovaChildrenPage extends StatefulWidget {
  const RecovaChildrenPage({Key? key}) : super(key: key);

  @override
  _RecovaChildrenPageState createState() => _RecovaChildrenPageState();
}

class _RecovaChildrenPageState extends State<RecovaChildrenPage> {
  List<DropdownMenuItem<String>> ListObjectType = [];
  TextEditingController ownerObjectController = TextEditingController();
  TextEditingController loseSideObjectController = TextEditingController();
  TextEditingController objectDescriptionController = TextEditingController();
  TextEditingController contactOwnerObjectController =
  TextEditingController(text: oneUserDataDico["telephone"].toString().isNotEmpty? oneUserDataDico["telephone"]: oneUserDataDico["telephone2"]);
  List<Widget> formPerduList = [];
  bool isAllLoading = true;

  Future pendingFunction() async {
    try {
      await getOneUserDataById();
      setState(() {
        isAllLoading = false;
      });
    } catch (e) {
      Navigator.pop(context);
      showSimpleDialog(title: "RECOVA", context: context, message: "Une erreur s'est produite");
    }
  }

  void validateRecoverObject() async {
    if (objectImageData["path"] == "" || objectImageData["name"] == "") {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "La photo est obligatoire !",
          context: context);
      return;
    } else if (loseSideObjectController.text.isEmpty ||
        contactOwnerObjectController.text.isEmpty ||
        ownerObjectController.text.isEmpty) {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
          "Le nom, votre position et votre contact sont obigatoires !",
          context: context);
      return;
    }
    var status = await sendRecoverOrLoseThingData(
        imagesPath: objectImageData["path"],
        imageName: objectImageData["name"],
        objectType: "Enfant",
        categorie: "R",
        loseOrNowSide: loseSideObjectController.text,
        holderLoseOrOwnerNumber: contactOwnerObjectController.text,
        objectOrOwnerName: ownerObjectController.text,
        objectDescription: objectDescriptionController.text);
    print("voici status: $status");
    if (status["status"] == "yes") {
      loseSideObjectController.clear();
      // idObjectController.clear();
      objectDescriptionController.clear();
      objectImageData["path"] = "";
      objectImageData["name"] = "";
      if (status["data"] != "none") {
        Navigator.of(context).pop();
        var route = MaterialPageRoute(
          builder: (BuildContext context) => InitialSearchPage(
            key: UniqueKey(),
            data: status["data"],
          ),
        );
        Navigator.of(context).push(route);
      } else {
        showSimpleSnackbar(
            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
            message: "L'enfant a été publié avec succès",
            context: context);
        Navigator.of(context).pop();
        Navigator.of(context).pop();

      }
    } else {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
          "Une erreur est survenue lors de la publication; Veuillez réessayer !",
          context: context);
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


  void refreshParentState(BuildContext context) {
    setState(() {
    });}

  @override
  void dispose() {
    contactOwnerObjectController.dispose();
    objectDescriptionController.dispose();
    ownerObjectController.dispose();
    loseSideObjectController.dispose();
    objectImageData["name"] = "";
    objectImageData["path"] = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    formPerduList.clear();
    formPerduList.addAll([

      nameWiget(ownerObjectController, "Saisissez le nom de l'enfant"),
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
      descriptionWidget(objectDescriptionController, "Décrivez l'enfant ou les circonstances dans lesquelles vous l'avez retrouvé"),
      const SizedBox(
        height: 10,
      ),
      // dateWidget(selectRecoverOrLoseDate, context, "Date de recouvrement", refreshParentState),
      // const SizedBox(
      //   height: 30,
      // ),
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
      formPerduList.removeAt(9);
      formPerduList.insert(9, ShowChoiceImage(context: context,
        listWidget: formPerduList, refreshParentState: refreshParentState,));
    }

    return isAllLoading? transitionWidget(): MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        key: const PageStorageKey<String>("perdu"),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: recovaColor,
          centerTitle: true,
          toolbarHeight: 40,
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
            "Enfant retrouvé",
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
          key: const PageStorageKey<String>("enfant retrouve"),
          child: Container(
            color: Colors.black.withOpacity(0.05),

            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                infoObjectPageHead("Vous avez retrouvé un enfant égaré ?"),
                const SizedBox(
                  height: 10,
                ),

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
