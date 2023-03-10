import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';
import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';

class OtherRecoverObjectPage extends StatefulWidget {
  const OtherRecoverObjectPage({Key? key}) : super(key: key);

  @override
  _OtherRecoverObjectPageState createState() => _OtherRecoverObjectPageState();
}

class _OtherRecoverObjectPageState extends State<OtherRecoverObjectPage> {
  TextEditingController typeObjectController = TextEditingController();
  TextEditingController ownerObjectController =
      TextEditingController(text: oneUserDataDico["fullname"]);
  TextEditingController loseSideObjectController = TextEditingController();
  TextEditingController objectDescriptionController = TextEditingController();
  TextEditingController contactOwnerObjectController =
      TextEditingController(text: oneUserDataDico["telephone"]);
  List<Widget> formPerduList = [];
  bool isAllLoading = true;

  void validateRecoverObject() async {
    // print(typeObjectController.text);
    // return;
    if (objectImageData["path"] == "" || objectImageData["name"] == "") {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "La photo est obligatoire !",
          context: context);
      return;
    } else if (loseSideObjectController.text.isEmpty ||
        contactOwnerObjectController.text.isEmpty ||
        ownerObjectController.text.isEmpty) {
      print(loseSideObjectController.text);
      print(contactOwnerObjectController.text);
      print(ownerObjectController.text);
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
        otherType: typeObjectController.text,
        categorie: "R",
        objectType: "Autres",
        loseOrNowSide: loseSideObjectController.text,
        holderLoseOrOwnerNumber: contactOwnerObjectController.text,
        objectOrOwnerName: ownerObjectController.text,
        objectDescription: objectDescriptionController.text);
    print("voici status: $status");
    if (status["status"] == "yes") {
      // loseSideObjectController.clear();
      // // idObjectController.clear();
      // objectDescriptionController.clear();
      // objectImageData["path"] = "";
      // objectImageData["name"] = "";
      if (status["data"] != "none") {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        var route = MaterialPageRoute(
          builder: (BuildContext context) => InitialSearchPage(
            key: UniqueKey(),
            data: status["data"],
          ),
        );
        Navigator.of(context).push(route);
      } else {
        Navigator.of(context).pop();
        showSimpleSnackbar(
            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
            message: "Publication éffectuée avec succès !",
            context: context);
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
              "Une erreur est survenue lors de la publication; Veuillez réessayer !",
          context: context);
    }
  }

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

  @override
  void initState() {
    // TODO: implement initState
    if (isAllLoading) {
      pendingFunction();
    }
    super.initState();
  }

  Widget otherObjectTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Type:",
          style: TextStyle(
              color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            maxLength: 20,
            autocorrect: false,
            controller: typeObjectController,
            decoration: InputDecoration(
                // border: const UnderlineInputBorder(
                //     borderSide: BorderSide(color: recovaColor, width: 20)),
                // enabledBorder: OutlineInputBorder(
                //     borderSide: const BorderSide(
                //       color: recovaColor,
                //       width: 1,
                //     ),
                //     borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                // errorText: loseSideObjectController.text.isEmpty
                //     ? "Ce champs est obligatoire"
                //     : null,

                fillColor: recovaColor,
                hoverColor: recovaColor,
                labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
                labelText: "Indiquez le type d'objet",
                prefixIcon: const Icon(
                  Icons.type_specimen_outlined,
                  color: recovaColor,
                ),
                suffixIcon: FutureBuilder(
                  builder: (ctx, snapshots) {
                    if (snapshots.connectionState == ConnectionState.done) {
                      if (snapshots.hasError) {
                        return Center(
                            child: Center(
                                child: errorPageWidget(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    assetImage:
                                    "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                                    context: context)));
                      } else if (snapshots.hasData) {
                        final datas = snapshots.data as List<dynamic>;
                        List<SelectedListItem> listObjectType = datas.map((e) => SelectedListItem(
                            name: e["otherType"], value: e["otherType"]))
                            .toSet()
                            .toList();
                        return IconButton(
                            onPressed: () async {
                              DropDownState(
                                DropDown(
                                    bottomSheetTitle: const Text(
                                      "Type d'objet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    data: listObjectType,
                                    selectedItems: (List<dynamic> selectedList) {
                                      List<String> list = [];
                                      for (var item in selectedList) {
                                        if (item is SelectedListItem) {
                                          list.add(item.name);
                                        }
                                      }
                                      // setState(() {
                                      typeObjectController.text = list[0];
                                      // });
                                    },
                                    isSearchVisible: true
                                  // enableMultipleSelection: true,
                                ),
                              ).showModal(context);
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: recovaColor,
                            ));
                      }
                    }
                    return miniTransitionWidget();
                  },
                  future: getAllOtherTypeObject(),
                )),
            cursorColor: recovaColor,
            style: const TextStyle(color: recovaColor, fontSize: 25),
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  void refreshParentState(BuildContext context) {
    setState(() {});
  }

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
      otherObjectTypeWidget(),
      const SizedBox(
        height: 10,
      ),
      sideWidget(loseSideObjectController, "Votre localisation", context),
      const SizedBox(
        height: 10,
      ),
      nameWiget(ownerObjectController, "Saisissez votre nom complet"),
      const SizedBox(
        height: 10,
      ),
      contactWidget(contactOwnerObjectController),
      const SizedBox(
        height: 10,
      ),
      descriptionWidget(objectDescriptionController,
          "Décrivez l'objet ou les circonstances dans lesquelles vous l'avez retrouvé"),
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
      addImageLine(
        showFooterActionImagePerduChoice: showFooterActionImagePerduChoice,
        context: context,
        refreshParentState: refreshParentState,
        listWidget: formPerduList,
      ),
    ]);
    if (objectImageData["path"]!.isNotEmpty) {
      formPerduList.removeAt(11);
      formPerduList.insert(
          11,
          ShowChoiceImage(
            context: context,
            listWidget: formPerduList,
            refreshParentState: refreshParentState,
          ));
    }

    return isAllLoading
        ? transitionWidget()
        : MaterialApp(
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
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.white)),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.help_outline_outlined,
                        color: Colors.white,
                      ))
                ],
                title: const Text(
                  "Autres objets",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              bottomNavigationBar: Container(
                color: recovaColor,
                height: 60,
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 18),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      validateRecoverObject();
                    },
                    splashColor: Colors.white,
                    hoverColor: recovaMixColor,
                    focusColor: recovaMixColor,
                    highlightColor: recovaMixColor,
                    child: const Center(
                      child: Text(
                        "Envoyer",
                        style: TextStyle(
                            color: recovaColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                key: const PageStorageKey<String>("object retrouve"),
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      infoObjectPageHead("Vous avez retrouvé un objet quelconque égaré ?"),
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
