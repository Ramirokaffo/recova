import 'package:flutter/material.dart';
import 'package:projet_flutter2/main.dart';
import 'ConstantFile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'MiniFunctionFile.dart';


class ChoiceUserNamePage extends StatefulWidget {

  const ChoiceUserNamePage({Key? key}) : super(key: key);

  @override
  _ChoiceUserNamePageState createState() => _ChoiceUserNamePageState();
}

class _ChoiceUserNamePageState extends State<ChoiceUserNamePage> {
  TextEditingController usernameController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<
      ScaffoldMessengerState>();
  // bool isAccountCreate = false;

  Widget OwnRadioListTile(String value) {
    return RadioListTile(
      title: Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: (String? value) {
        setState(() {
          usersName = value;
        });
      },
      groupValue: usersName,
    );
  }

  Widget listUsersNameChoice() {
    if (userNameList.length == 1) {
      return OwnRadioListTile(userNameList[0]);
    } else if (userNameList.length == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OwnRadioListTile(userNameList[0]),
          OwnRadioListTile(userNameList[1])
        ],
      );
    } else {
      return Column(
        children: [
          OwnRadioListTile(userNameList[0]),
          OwnRadioListTile(userNameList[1]),
          OwnRadioListTile(userNameList[2])
        ],
      );
    }
  }


  Future<bool> loginChoiceUserName(String username) async {
    late Map<String, dynamic> jsonResponse;
    var url = Uri.http(uri, 'user/userUpdateAccount');
    var response = await http.post(url, body: {
      "username": username
    }, headers: {
      "authorization":
      "Bearer ${await localBdSelectSetting("token")}"
    });

    if (response.statusCode == 201) {
      jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == "yes") {
        // Navigator.of(context).popAndPushNamed("RecovaHomePage");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // Future<bool> loginAccountCreate(
  //     String email, String fullname, String phone, BuildContext context) async {
  //   if (email == "" || fullname == "" || phone == ""){
  //     showSimpleSnackbar(
  //         rootScaffoldMessengerKey: rootScaffoldMessengerKey,
  //         message: "Vous devez renseigner toutes les informations", context: context);
  //     return false;
  //   }
  //   try {
  //     late Map<String, dynamic> jsonResponse;
  //     var url = Uri.http(uri, 'user/userCreateAccount');
  //     print("Je suis d'abord ici hein !");
  //
  //     var response = await http.post(url, body: {
  //       "fullname": fullname,
  //       "email": email,
  //       "telephone": phone,
  //     }, headers: {});
  //     print("Je suis comme ca ici hein !");
  //     print(response.body);
  //     print(response.statusCode);
  //     print("Je suis comme ca ici hein 3!");
  //     if (response.statusCode == 201) {
  //       jsonResponse =
  //       await convert.jsonDecode(response.body) as Map<String, dynamic>;
  //       print(jsonResponse);
  //       if (jsonResponse["status"] == "yes") {
  //         await localBdChangeSetting("account", "yes");
  //         await localBdChangeSetting("token", jsonResponse["access_token"]);
  //         var userNameLis = jsonResponse["userNameList"];
  //         for (var username in userNameLis) {
  //           userNameList.add(username);
  //         }
  //         print(userNameList);
  //         usersName = userNameList[0];
  //         // Navigator.of(context).push(MaterialPageRoute(
  //         //     builder: (context) => const ChoiceUserNamePage()));
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print("il y'a erreur");
  //     return false;
  //   }
  // }
  //
  // Future accountCreate() async {
  //   if (await loginAccountCreate(widget.email, widget.fullname, widget.phone, context)) {
  //     setState(() {
  //       isAccountCreate = true;
  //     });
  //   } else {
  //     setState(() {
  //       isAccountCreate = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // if (!isAccountCreate) {
    //   accountCreate();
      // loginAccountCreate(widget.email, widget.fullname, widget.phone, context);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext contexte) {
    // TODO: implement build
    return MaterialApp(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: UniqueKey(),
        backgroundColor: recovaColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: recovaColor,
          centerTitle: true,
          toolbarHeight: 40,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          },
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
          title: const Text(
            "Nom d'utilisateur",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Selectionnez votre nom d'utilisateur:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          listUsersNameChoice(),
                          const SizedBox(
                            height: 30,
                          ),
                          const ExpansionTile(
                            title: Text(
                              "Nom d'utilisateur personnalisé:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            collapsedIconColor: Colors.white,
                            children: [
                              Text(
                                "Si vous saisissez un nom d'utilisateur, "
                                "ce dernier sera prioritaire",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white12,
                            ),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                  fillColor: recovaColor,
                                  hoverColor: recovaColor,
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  labelText: "Entrez votre username personnalisé",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white54,
                                  )),
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Container(
                        width: 380,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () async {
                            // Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecovaHomePage(
                                  pendingFunction: () async {
                                    if (usernameController.text.isNotEmpty) {
                                      if (await loginChoiceUserName(usernameController.text)) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    } else {
                                      if (await loginChoiceUserName(usersName!)) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    }
                                  },
                                )));

                            // showSimpleSnackbar(
                            //     rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                            //     message: 'Votre compte a été créé avec succès',
                            //     context: context,);
                            // rootScaffoldMessengerKey.currentState
                            //     ?.showSnackBar(SnackBar(
                            //   content: const Text('Votre compte a été créé avec succès'),
                            //   duration: const Duration(seconds: 5),
                            //   action: SnackBarAction(
                            //     label: 'Ok',
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //   ),
                            // ));
                          },
                          splashColor: recovaMixColor,
                          hoverColor: recovaMixColor,
                          focusColor: recovaMixColor,
                          highlightColor: recovaMixColor,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: const Center(
                              child: Text(
                                "Continuer",
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
