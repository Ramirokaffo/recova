import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';

class SaveMyDataFormPage extends StatefulWidget {
  final Function refreshState;
  const SaveMyDataFormPage({Key? key, required this.refreshState}) : super(key: key);

  @override
  _SaveMyDataFormPageState createState() => _SaveMyDataFormPageState();
}

class _SaveMyDataFormPageState extends State<SaveMyDataFormPage> {
  String? objectTypeController;
  TextEditingController newObjectTypeController = TextEditingController();
  bool isOpen = false;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onTextFieldTap() {
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
          data: newListObjectType ?? [],
          selectedItems: (List<dynamic> selectedList) {
            List<String> list = [];
            for (var item in selectedList) {
              if (item is SelectedListItem) {
                list.add(item.name);
              }
            }
            print(list);
            setState(() {
              newObjectTypeController.text = list[0];
            });
            showSnackBar(list.toString());
          },
          isSearchVisible: true),
    ).showModal(context);
  }

  @override
  void dispose() {
    super.dispose();
    newObjectTypeController.dispose();

  }
  @override
  void initState() {
    newGetAllObjectType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController objectNomberController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Mes données",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: recovaColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.refreshState();
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Type:",
                  style: TextStyle(
                      color: recovaColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: TextFormField(
                    controller: newObjectTypeController,
                    style: const TextStyle(color: recovaColor),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: recovaColor, width: 20)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: recovaColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10)),
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
                    ),
                    onTap: () {

                      FocusScope.of(context).unfocus();
                      onTextFieldTap();
                    },
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Identifiant:",
                  style: TextStyle(
                      color: recovaColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLength: 20,
                  controller: objectNomberController,
                  style: const TextStyle(color: recovaColor),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: recovaColor, width: 20),),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: recovaColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(
                        Icons.key,
                        color: recovaColor,
                      ),
                      iconColor: recovaColor,
                      labelText: "Saisissez l'identifiant",
                      labelStyle:
                          const TextStyle(color: recovaColor, fontSize: 25),
                      hintText: "sample: 20201289481803984",
                      hintStyle:
                          const TextStyle(color: recovaColor, fontSize: 15),
                      icon: null),
                ),
                const SizedBox(
                  height: 50,
                ),
                buttonInfo("Enregistrer", () {
                  try {
                    var a = newListObjectType.singleWhere((element) =>
                        element.name == newObjectTypeController.text);
                    print(a.name);
                  } catch (e) {
                    showSimpleSnackbar(
                        rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                        message: "Le type d'objet est incorrect",
                        context: context, );
                    return;
                  }

                  if (objectNomberController.text.isEmpty) {
                    showSimpleSnackbar(
                        rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                        message: "L'identifiant est obligatoire",
                        context: context);
                    return;
                  } else if (newObjectTypeController.text.isEmpty) {
                    showSimpleSnackbar(
                        rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                        message: "Vous n'avez pas selectionné le type d'object",
                        context: context);
                    return;
                  } else {
                    saveUserObjectData(
                        objectType: newObjectTypeController.text,
                        objectNumber: objectNomberController.text);
                    newObjectTypeController.clear();
                    objectNomberController.clear();
                    showSimpleSnackbar(
                        rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                        message: "Enregistrement éffectué avec succès",
                        context: context);
                    widget.refreshState();
                  }
                }, context),
              ],
            ),
          ),
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
    shadowColor: Colors.white,
    child: InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ),
  );
}
