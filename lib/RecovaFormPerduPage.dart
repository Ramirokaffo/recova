import 'dart:async';
import 'dart:io';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/recovaInitialSearchPage.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/LocalNotificationWidget.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'HomeRetrouvePage.dart';
import 'notificationservice.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart' ;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';



final bucketGlobal = PageStorageBucket();

class RecovaLostThingForm extends StatefulWidget {
  const RecovaLostThingForm({Key? key}) : super(key: key);

  @override
  _RecovaLostThingFormState createState() => _RecovaLostThingFormState();
}

class _RecovaLostThingFormState extends State<RecovaLostThingForm> with TickerProviderStateMixin {
  TextEditingController idObjectController = TextEditingController();
  TextEditingController objectTypeController = TextEditingController();
  TextEditingController ownerObjectController =
      TextEditingController(text: oneUserDataDico["fullname"]);
  TextEditingController loseSideObjectController = TextEditingController();
  TextEditingController objectDescriptionController = TextEditingController();
  TextEditingController contactOwnerObjectController =
      TextEditingController(text: oneUserDataDico["telephone"].toString().isNotEmpty? oneUserDataDico["telephone"]: oneUserDataDico["telephone2"].isNotEmpty? oneUserDataDico["telephone2"]: "+237");
  // late AnimationController _controller;
  bool isAllLoading = true;
  // NotificationService service = NotificationService();

  bool backpressed = true;
  late AnimationController controllerToIncreaseCurve;
  late AnimationController controllerToDecreaseCurve;

  late Animation <double> animationToIncreasingCurve;
  late Animation <double> animationToDecreasingCurve;

  _sendingMails() async {
    var url = Uri.parse("mailto:ramirokaffo@icloud.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  void validateRecoverObject() async {
    // Timer(Duration(seconds: 3), (){Navigator.of(context).pop();});

    // return;
    try {
      if (objectTypeController.text.isEmpty) {
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
      } else if (!validateDescription(objectDescriptionController.text)) {
        showSimpleSnackbar(
            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
            message:
            "La description de doit pas contenir vos informations d'indentification!",
            context: context);
        return;
      }
      if (!contactOwnerObjectController.text.contains("+")) {
        contactOwnerObjectController.text = "+237${contactOwnerObjectController.text}";
      }
      waitSendingDataWidget(context);
      var status = await sendRecoverOrLoseThingData(
          imagesPath: objectImageData["path"],
          imageName: objectImageData["name"],
          objectType: objectTypeController.text,
          categorie: "P",
          loseOrNowSide: loseSideObjectController.text,
          holderLoseOrOwnerNumber: contactOwnerObjectController.text,
          objectNumber: idObjectController.text,
          objectOrOwnerName: ownerObjectController.text,
          objectDescription: objectDescriptionController.text);
      print("voici status: $status");
      if (status["status"] == "yes") {
        // Navigator.of(context).pop();
        // loseSideObjectController.clear();
        // idObjectController.clear();
        // objectDescriptionController.clear();
        // objectImageData["path"] = "";
        // objectImageData["name"] = "";
        if (status["data"] != "none") {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => InitialSearchPage(
              key: UniqueKey(),
              data: status["data"],
            ),
          );
          Navigator.of(context).push(route);
        } else {
          Navigator.of(context).pop();
          // showSimpleSnackbar(
          //     rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          //     message: "Publication éffectuée avec succès",
          //     context: context);
          // Timer(Duration(seconds: 2), () {
          //   Navigator.of(context).pop();
          // });
        }

        // Navigator.of(context).pop();

      } else {
        Navigator.of(context).pop();
        showSimpleSnackbar(
            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
            message:
            "Une erreur est survenue lors de la publication; Veuillez réessayer !",
            context: context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message:
          "Une erreur est survenue; Veuillez réessayer !",
          context: context);
    }

  }

  @override
  void dispose() {
    // _controller.dispose();
    controllerToIncreaseCurve.dispose();
    controllerToDecreaseCurve.dispose();
    contactOwnerObjectController.dispose();
    objectDescriptionController.dispose();
    ownerObjectController.dispose();
    loseSideObjectController.dispose();
    idObjectController.dispose();
    objectImageData["name"] = "";
    objectImageData["path"] = '';
    super.dispose();
  }

  Future pendingFunction() async {
    try {
      await newGetAllObjectType();
      await getOneUserDataById();
      setState(() {isAllLoading = false;});
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

    // setState(() {
    //   newGetAllObjectType();
    //   getOneUserDataById();
    // });
    controllerToIncreaseCurve = AnimationController(vsync: this, duration: const Duration(seconds: 3), upperBound: 1.3);
    controllerToDecreaseCurve = AnimationController(vsync: this, duration: const Duration(seconds: 3), upperBound: 1.3);
    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
        CurvedAnimation(parent: controllerToIncreaseCurve,
            curve: Curves.fastLinearToSlowEaseIn))..addListener(() {setState(() {

            });});
    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
        CurvedAnimation(parent: controllerToDecreaseCurve,
            curve: Curves.fastLinearToSlowEaseIn))..addListener(() {setState(() {

            });});
    controllerToIncreaseCurve.forward();
    super.initState();

  }



  Future mailSend() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['ramirokaffo@icloud.com'],
      cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }



  List<Widget> formPerduList = [];

  void refreshParent(BuildContext context) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    formPerduList.clear();
    formPerduList.addAll([
      typeWidget(objectTypeController, showDropDownListTypeObject, context),
      const SizedBox(
        height: 30,
      ),
      idWidget(idObjectController),
      const SizedBox(
        height: 20,
      ),
      nameWiget(ownerObjectController, "Saisissez votre nom complet"),
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
      descriptionWidget(objectDescriptionController, "Décrivez l'objet ou les circonstances dans lesquelles vous l'avez perdu"),
    // const SizedBox(height: 10,),
    //   dateWidget(selectRecoverOrLoseDate, context, "Date à laquelle vous avez perdu l'objet", refreshParent),
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
          context: context, refreshParentState: refreshParent, listWidget: formPerduList,),
    ]);
    if (objectImageData["path"]!.isNotEmpty) {
      formPerduList.removeAt(13);
      formPerduList.insert(13, ShowChoiceImage(context: context,
        listWidget: formPerduList, refreshParentState: refreshParent,));
    }

    return isAllLoading? transitionWidget(): WillPopScope(
      onWillPop: () async {
        backpressed = true;
        controllerToDecreaseCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(backpressed == false? animationToIncreasingCurve.value
        :animationToDecreasingCurve.value),
        child: PageStorage(
          bucket: bucketGlobal,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            home: Scaffold(
              key: const PageStorageKey<String>("perdu"),
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: recovaColor,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
                centerTitle: true,
                toolbarHeight: 40,
                actions: [
                  IconButton(
                      onPressed: () async {
                        // _sendingMails();
                        // await mailSend();
                        // Navigator.of(context).pushNamed("IconStepperDemos");
                        // return;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LocalNotificationWidget(),));
                        // Navigator.of(context).pushNamed("soir");
                        // _controller.reverse().then((value) => Navigator.of(context).pop());
                      },
                      icon: const Icon(
                        Icons.help_outline_rounded,
                        color: Colors.white,
                      ))
                ],
                title: const Text(
                  "Objet perdu",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              bottomNavigationBar: Container(
                color: recovaColor,
                height: 50,
                padding: const EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
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
                child: Container(
                  color: Colors.black.withOpacity(0.05),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      infoObjectPageHead("Vous avez égaré un objet ?"),
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.black.withOpacity(0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: formPerduList,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// class MyClipper extends CustomClipper<Path> {
//     double value;
//   MyClipper(this.value);
//
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.addOval(Rect.fromCircle(center: Offset(size.width, size.height), radius: value = size.height));
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
//   }





bool validateDescription(String description) {
  if (description.toUpperCase().contains("MON NUMERO")) return false;
  if (description.toUpperCase().contains("JE VIE A")) return false;
  if (description.toUpperCase().contains("JE SUIS A")) return false;
  if (description.toUpperCase().contains("CONTACTER")) return false;
  if (description.toUpperCase().contains("APPELER")) return false;
  if (description.toUpperCase().contains("+237")) return false;
  // if (description.toUpperCase().contains("67")) return false;
  List<String> list = description.split(" ");
  List list2 = list.where((element) => (int.tryParse(element) != null && element.length >= 5)).toList();
  if (list2.isNotEmpty) {
    return false;
  } else {
    return true;
  }
}


Widget typeWidget(TextEditingController objectTypeController,
    Function showDropDownListTypeObject, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 5,),
      const Text(
        "Type:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
          ),
          child: TextFormField(
            enabled: true,
            controller: objectTypeController,
            style: const TextStyle(color: recovaColor),
            keyboardType: TextInputType.text,
            // strutStyle: StrutStyle.disabled,
            decoration: InputDecoration(
              filled: false,
              fillColor: Colors.white,
              isCollapsed: false,

              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              prefixIcon: const Icon(
                Icons.book,
                color: recovaColor,
              ),
              iconColor: recovaColor,
              labelText: "Choisissez le type d'objet",
              labelStyle: const TextStyle(
                color: recovaColor,
                fontSize: 25,
              ),
              // hintText: "sample: 20201289481803984",
              // hintStyle: const TextStyle(color: recovaColor, fontSize: 15)
            ),
            onTap: () async {
              FocusScope.of(context).unfocus();
              try {
                if (newListObjectType.isEmpty) {
                  newListObjectType = await newGetAllObjectType();
                  showDropDownListTypeObject(objectTypeController, context);
                } else {
                  print("non vide");
                  showDropDownListTypeObject(objectTypeController, context);
                }
              } catch (e) {
                showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Une erreur s'est produite", context: context);
              }
            },
          ),
        ),
      ),
    ],
  );
}

// Widget dateWidget(Function selectDateFunction,  BuildContext context , String helpText, Function stateToSet) {
//   return Column(
//     children: [
//       Row(
//         children: [
//           const Text(
//             "Date:",
//             style: TextStyle(
//                 color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.start,
//           ),
//           const SizedBox(
//             width: 235,
//           ),
//           Text(
//             dateTransorm(dateVariable.toString()),
//             style: const TextStyle(
//                 color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.start,
//           ),
//         ],
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       Container(
//         padding: const EdgeInsets.only(left: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: recovaColor,
//         ),
//         child: InkWell(
//           onTap: () {
//             selectDateFunction(context, helpText, stateToSet);
//           },
//           splashColor: Colors.white,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 15.0),
//             child: Row(
//               children: const [
//                 Expanded(
//                     flex: 1,
//                     child: Icon(Icons.date_range, color: Colors.white54)),
//                 Expanded(
//                   flex: 8,
//                   child: Text(
//                     "Selectionner la date",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.justify,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget descriptionWidget(TextEditingController objectDescriptionController, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Description:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        // padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          maxLength: 100,
          autocorrect: false,
          controller: objectDescriptionController,
          maxLines: 2,
          decoration: InputDecoration(
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: recovaColor, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              fillColor: recovaColor,
              hoverColor: recovaColor,
              hintStyle: const TextStyle(color: recovaColor, fontSize: 15),
              labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelText: "Ajouter une description",
              hintText: hintText,
              prefixIcon: const Icon(
                Icons.description_outlined,
                color: recovaColor,
              ),
          ),
          cursorColor: recovaColor,
          style: const TextStyle(color: recovaColor, fontSize: 25),
          keyboardType: TextInputType.text,
        ),
      ),
    ],
  );
}

Widget contactWidget(TextEditingController contactOwnerObjectController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Contact:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          maxLength: 15,
          controller: contactOwnerObjectController,
          autocorrect: false,
          decoration: InputDecoration(
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: recovaColor, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              errorText: contactOwnerObjectController.text.isEmpty
                  ? "Ce champ est obligatoire"
                  : null,
              fillColor: recovaColor,
              hoverColor: recovaColor,
              hintStyle: const TextStyle(color: recovaColor),
              labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelText: "Saisissez votre contact",
              hintText: "Téléphone",
              prefixIcon: const Icon(
                Icons.call,
                color: recovaColor,
              )),
          cursorColor: recovaColor,
          style: const TextStyle(color: recovaColor, fontSize: 25),
          keyboardType: TextInputType.text,
        ),
      ),
    ],
  );
}

Widget sideWidget(TextEditingController loseSideObjectController, String labelText, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Lieu:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          maxLength: 30,
          autocorrect: false,
          controller: loseSideObjectController,
          decoration: InputDecoration(
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: recovaColor, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
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
              // hintStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelText: labelText,
              // hintText: "sample: Yaoundé-Bonas",
              prefixIcon: const Icon(
                Icons.location_on,
                color: recovaColor,
              )),
          cursorColor: recovaColor,
          style: const TextStyle(color: recovaColor, fontSize: 25),
          keyboardType: TextInputType.text,
          onTap: (){
            DropDownState(
              DropDown(
                  bottomSheetTitle: const Text(
                    "Votre Region actuelle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  data: camerounRegion.map((e) => SelectedListItem(name: e, value: e)).toList(),
                  selectedItems: (List<dynamic> selectedList) {
                    List<String> list = [];
                    for (var item in selectedList) {
                      if (item is SelectedListItem) {
                        list.add(item.name);
                      }
                    }
                    // setState(() {
                    loseSideObjectController.text = list[0];
                    // });
                  },
                  isSearchVisible: true
                // enableMultipleSelection: true,
              ),
            ).showModal(context);
          },
        ),
      ),
    ],
  );
}

Widget nameWiget(TextEditingController ownerObjectController, String labelText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Nom complet:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          maxLength: 30,
          autocorrect: false,
          controller: ownerObjectController,
          decoration: InputDecoration(
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: recovaColor, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              // errorText: ownerObjectController.text.isEmpty
              //     ? "Ce champs est obligatoire"
              //     : null,
              fillColor: recovaColor,
              hoverColor: recovaColor,
              labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelText: labelText,
              prefixIcon: const Icon(
                Icons.person,
                color: recovaColor,
              )),
          cursorColor: recovaColor,
          style: const TextStyle(color: recovaColor, fontSize: 25),
          keyboardType: TextInputType.text,
        ),
      ),
    ],
  );
}

Widget idWidget(TextEditingController idObjectController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Numero/Matricule/Identifiant unique:",
        style: TextStyle(
            color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
  borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          maxLength: 20,
          controller: idObjectController,
          autocorrect: false,
          decoration: InputDecoration(
              // border: const UnderlineInputBorder(
              //     borderSide: BorderSide(color: recovaColor, width: 20)),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: const BorderSide(
              //       color: Colors.black,
              //       width: 1,
              //     ),
              //     borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              // errorText: idObjectController.text.isEmpty
              //     ? "Ce champs est obligatoire"
              //     : null,
              fillColor: recovaColor,
              hoverColor: recovaColor,
              hintStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelStyle: const TextStyle(color: recovaColor, fontSize: 20),
              labelText: "Veuillez saisir l'Identifiant",
              hintText: "sample: 2019024556877581",
              prefixIcon: const Icon(
                Icons.key,
                color: recovaColor,
              )),
          cursorColor: recovaColor,
          style: const TextStyle(color: recovaColor, fontSize: 25),
          keyboardType: TextInputType.text,
        ),
      ),
    ],
  );
}


void showDropDownListTypeObject(TextEditingController controller, BuildContext context) {

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
        data: newListObjectType,
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
            }
          }
          // setState(() {
          controller.text = list[0];
          // });
        },
        isSearchVisible: true
      // enableMultipleSelection: true,
    ),
  ).showModal(context);
}


void showFooterActionImagePerduChoice(
    {required BuildContext context,
    Function? refreshParentState,
    List<Widget>? listWidget}) {
  late final XFile? image;
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    flex: 10,
                    child: Text(
                      "Image",
                      style: TextStyle(
                          color: recovaColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: recovaColor,
                          )))
                ],
              ),
              const Divider(
                height: 70,
                color: recovaColor,
              ),
              oneOptionToShow(title: "Galerie photo", onTap: () async {
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.gallery);
                objectImageData["name"] = image!.name;
                objectImageData["path"] = image!.path;

                if (listWidget != null) {
                      listWidget.add(Image.asset(objectImageData["path"]!));
                    }
                    print(objectImageData);
                Navigator.of(context).pop();
                if (refreshParentState != null) {
                  refreshParentState(context);
                    }

              }, icon: Icons.image, size: 25),

              const SizedBox(
                height: 20,
              ),
              oneOptionToShow(title: "Appareil photo", onTap: () async {
                Navigator.of(context).pop();
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.camera);
                objectImageData["name"] = image!.name;
                objectImageData["path"] = image!.path;
                if (listWidget != null) {
                  listWidget.add(Image.asset(objectImageData["path"]!));
                }
                print(objectImageData);
                Navigator.of(context).pop();
                if (refreshParentState != null) {
                  print("oui");
                  refreshParentState();
                }
              }, icon: Icons.camera_alt, size: 25),

            ],
          ),
        );
      });
}


class addImageLine extends StatefulWidget
{
  BuildContext context;
  Function showFooterActionImagePerduChoice;
  Function? refreshParentState;
  List<Widget> listWidget;
  addImageLine({super.key, required this.showFooterActionImagePerduChoice,
    required this.context, this.refreshParentState, required this.listWidget});

  @override
  _addImageLineState createState() => _addImageLineState();
}

class _addImageLineState extends State<addImageLine>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: recovaColor,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.image, color: Colors.white54)),
              ),
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: () async {
                    await widget.showFooterActionImagePerduChoice(context: widget.context, refreshParentState: widget.refreshParentState, listWidget: widget.listWidget);
                  },
                  splashColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text(
                      "Ajouter une image",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}




class ShowChoiceImage extends StatefulWidget
{
  BuildContext context;
  Function? refreshParentState;
  List<Widget> listWidget;
  ShowChoiceImage({super.key, required this.context, this.refreshParentState, required this.listWidget});

  @override
  _ShowChoiceImage createState() => _ShowChoiceImage();
}

class _ShowChoiceImage extends State<ShowChoiceImage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,

          ),

          child: Center(

            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () {
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => DisplaysImage(
                        key: UniqueKey(),
                        image: objectImageData["path"]!,
                        islocal: true,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: Image.file(
                    File(objectImageData["path"]!),
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                  ),
                )),
          ),
        ),
        Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: recovaColor,
                ),
                onPressed: () {
                  showFooterActionImagePerduChoice(context: widget.context,
                      refreshParentState: widget.refreshParentState, listWidget: widget.listWidget);
                },
              ),
            )),

      ],
    );
  }

}


Future selectRecoverOrLoseDate(BuildContext context, String helpText, Function stateToSet) async {
  DateTime? picker = await showDatePicker(
      helpText: helpText,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
      fieldLabelText: "Veuillez entrer la date");
  if (picker != null) {
      dateVariable = picker.toString();
      stateToSet(context);

  }
}