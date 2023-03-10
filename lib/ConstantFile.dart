import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

String dateVariable = DateTime.now().toString();

List<DropdownMenuItem<String>> ListObjectType = [];
List<SelectedListItem> newListObjectType = [];

const Color recovaColor = Colors.deepPurple;
const Color recovaMixColor = Colors.deepPurpleAccent;
String? usersName = "";

var loginContaint = '';
var pinCode = "";
List ownItemList = [];
List<String> userNameList = [];
List<dynamic> objectSearchList = [];
List<dynamic> userObjectSaveList = [];
String userCountryCode = "";
var oneUserDataDico = {};
late int curentObjectIndex;
late String curentObjectCategorie;
bool pinCodeExist = false;
bool pinIsRequired = false;
int createAccountIndicator = 1;
const String placeholder = 'images/Curve-Loading.gif';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Map<int, String> objectIdToName = {
  1: "CNI",
  2: "VISA",
  3: "Enfant",
  4: "Acte de naissance",
  5: "Diplôme",
  6: "Passport",
  7: "Permis de conduire",
  8: "Corps sans vie",
  9: "Autres"
};

var directory = "/Users/user/StudioProjects/projet_flutter2/images/";
List list_image_asset = [
  "${directory}4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "${directory}6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "${directory}6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "${directory}9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "${directory}21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "${directory}520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "${directory}950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "${directory}73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "${directory}A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "${directory}CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "${directory}ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "${directory}FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
];

Map<String, String> objectImageData = {"name": "", "path": ""};

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}


List<String> camerounRegion = ["Centre", "Littoral", "Ouest", "Sud", "Sud-Ouest",
  "Nord-Ouest", "Est", "Adamaoua", "Nord", "Extrême Nord"];


String dateTransorm(String realDate) {
  List list = realDate.substring(0, 10).split("-");
  list = list.reversed.toList();
  return list.join("-");
}



void showSimpleSnackbar(
    {required GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey,
    required String message,
    String label = "OK",
    bool popContext = false,
    required BuildContext context,
    int duration = 5}) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: duration),
    action: SnackBarAction(
      textColor: recovaColor,
      label: label,
      onPressed: () {
        if (popContext) {
          Navigator.of(context).pop();
        }
      },
    ),
    behavior: SnackBarBehavior.floating,
  ));
}

Widget emptyPageWidget(
    {required BuildContext context,
      required Function onTap,
      required String assetImage,
      String message = "Une erreur s'est produite lors du chargement de la page",
      String buttonText = "Rafraîchir",
      IconData icon = Icons.refresh,
      double scale = 2,
      bool buttonIsVisible = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        assetImage,
        fit: BoxFit.fitWidth,
        scale: scale,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        message,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 20,
      ),
      Visibility(
        visible: buttonIsVisible,
        child: Container(
          height: 40,
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width * 2 / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: recovaColor,
              )),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: recovaColor),
                Text(
                  buttonText,
                  style: const TextStyle(
                      color: recovaColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}


Widget errorPageWidget(
    {required BuildContext context,
      required Function onTap,
      required String assetImage,
      String message = "Une erreur s'est produite lors du chargement de la page",
      String buttonText = "Rafraîchir",
      IconData icon = Icons.refresh,
      double scale = 2,
      bool buttonIsVisible = true}) {
  return Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetImage,
          fit: BoxFit.fitWidth,
          scale: scale,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          message,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: buttonIsVisible,
          child: Container(
            height: 40,
            alignment: AlignmentDirectional.center,
            width: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width * 2 / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: recovaColor,
                )),
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(icon, color: recovaColor),
                  Text(
                    buttonText,
                    style: const TextStyle(
                        color: recovaColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


// Widget emptyPageWidget(
//     {required BuildContext context,
//       required Function onTap,
//       required String assetImage,
//       String message = "Une erreur s'est produite lors du chargement de la page",
//       String buttonText = "Rafraîchir",
//       IconData icon = Icons.refresh,
//       double scale = 2,
//       bool buttonIsVisible = true}) {
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



void checkUnautoriseUser(BuildContext context) {
  showSimpleDialog(
      title: "RECOVA",
      context: context,
      isimgvisible: true,
      message:
          "Désolé, un compte utilisateur est requis pour éffectuer cette opération",
      actionText: "Créer un compte",
      onActionTap: () {
        Navigator.of(context).popAndPushNamed("CreateAccountPage");
      });
}

void showSimpleDialog(
    {required String title,
    required BuildContext context,
    required String message,
    String? actionText = "OK",
    bool isimgvisible = false,
    Function? onActionTap}) {
  showDialog(
    context: context,
    builder: (BuildContext contex) {
      return AlertDialog(
        scrollable: true,
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
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: isimgvisible,
                child: TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(fontSize: 18, color: recovaColor),
                  ),
                  onPressed: () {
                    objectImageData["name"] = "";
                    objectImageData["path"] = "";
                    Navigator.pop(contex);
                  },
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  onActionTap != null
                      ? onActionTap()
                      : Navigator.pop(contex);
                },
                child: Text(
                  actionText!,
                  style: const TextStyle(fontSize: 18, color: recovaColor),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
