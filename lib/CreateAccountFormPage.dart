import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/VerifyEmailPage.dart';
import 'package:projet_flutter2/firebase_service.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/ChoiceUsersNamePage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  String? def;
  List<DropdownMenuItem<String>> listObjectType = [];
  String recoverDate = DateTime.now().toString();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  bool ismailEnter = true;
  bool isnumberEnter = true;
  bool isnameEnter = true;
  AuthService authService = AuthService();
  bool isEmailVerify = false;
  final bucketGlobal = PageStorageBucket();

  Future<bool> loginAccountCreate(
      String email, String fullname, String phone, BuildContext context) async {
    if (email == "" || fullname == "" || phone == "") {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "Vous devez renseigner toutes les informations",
          context: context);
      return false;
    }
    try {
      late Map<String, dynamic> jsonResponse;
      var url = Uri.http(uri, 'user/userCreateAccount');
      print("Je suis d'abord ici hein !");

      var response = await http.post(url, body: {
        "fullname": fullname,
        "email": email,
        "telephone": phone,
      }, headers: {});
      print("Je suis comme ca ici hein !");

      print(response.body);
      print(response.statusCode);
      print("Je suis comme ca ici hein 3!");
      if (response.statusCode == 201) {
        jsonResponse =
            await convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(jsonResponse);
        if (jsonResponse["status"] == "yes") {
          await localBdChangeSetting("account", "yes");
          await localBdChangeSetting("token", jsonResponse["access_token"]);
          var userNameLis = jsonResponse["userNameList"];
          for (var username in userNameLis) {
            userNameList.add(username);
          }
          print(userNameList);
          usersName = userNameList[0];
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => const ChoiceUserNamePage()));
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print("il y'a erreur");
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("userCountryCode: ${userCountryCode}");
    // FirebaseAuth.instance.
    try {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      print(isEmailVerify);
    } catch (e) {
      //
    }
    super.initState();
  }
// BuildContext context = widget.context;

  void userCreateAccount() async {

// return;
//     final result = await Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => VerifyEmailPage(email: emailTextController.text),
//     ));
//
//     print("Pas ici");
//     return;
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => pleaseWaitWidget(context),
    // ));
    // Timer(Duration(seconds: 2), (){Navigator.of(context).pop();});
    // return;
    try {
      if (!isEmailVerify) {
        if (emailTextController.text.isEmpty) {
          ismailEnter = false;
          setState(() {});
          return;
        } else if (fullNameTextController.text.isEmpty) {
          isnameEnter = false;
          setState(() {});
          return;
        } else if (phoneTextController.text.isEmpty) {
          isnumberEnter = false;
          setState(() {});
          return;
        }

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => pleaseWaitWidget(context),
        ));

        final bool register = await authService
            .signUp(emailTextController.text, fullNameTextController.text)
            .whenComplete(() {
        });
        Navigator.of(context).pop();

        print("register: $register");

        if (!register) {
          showSimpleSnackbar(
              rootScaffoldMessengerKey: rootScaffoldMessengerKey,
              message: "Une erreur s'est produite, veuillez reéssayer !",
              context: context);
          return;
        } else {
          authService.sendVerificationEmail();
          final result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                VerifyEmailPage(email: emailTextController.text),
          ));
          // Navigator.pop(context);
          print("result: $result");
          if (result) {
            print("Je suis ici");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => pleaseWaitWidget(context),
            ));
            bool accountIsCreate = await loginAccountCreate(
                    emailTextController.text,
                    fullNameTextController.text,
                    phoneTextController.text,
                    context)
                .whenComplete(() {
              Navigator.pop(context);
            });
            // Navigator.pop(context);
            if (accountIsCreate) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChoiceUserNamePage(),
              ));
            }
          } else {
            return;
          }
          // showSimpleDialog(title: "RECOVA", context:
          // context, message: "Un lien de validation a été envoyé a cette adresse email \n"
          //     "Veuillez vérifier votre boite mail !",);
          return;
        }
        //  ramirokaffo@icloud.com
        //  RAMIRO KAFFO
        //  +237672279946
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => pleaseWaitWidget(context),
        ));
        bool accountIsCreate = await loginAccountCreate(
                emailTextController.text,
                fullNameTextController.text,
                phoneTextController.text,
                context)
            .whenComplete(() {
          Navigator.pop(context);
        });
        // Navigator.pop(context);
        if (accountIsCreate) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChoiceUserNamePage(),
          ));
        } else {
          showSimpleSnackbar(
              rootScaffoldMessengerKey: rootScaffoldMessengerKey,
              message: "Une erreur s'est produite, veuillez reéssayer !",
              context: context);
        }
      }
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyEmailPage(
      //   email: emailTextController.text,
      // ),));
      //   // sendVerificationEmail();
      //
      // bool register = await  authService.signUp(
      //     emailTextController.text, fullNameTextController.text);
      // print(register);
      // return;

      // showSimpleSnackbar(
      //     rootScaffoldMessengerKey: rootScaffoldMessengerKey,
      //     message: "Vous devez renseigner toutes les informations", context: context);
      //
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ChoiceUserNamePage()));
    } catch (e) {
      showSimpleSnackbar(
          rootScaffoldMessengerKey: rootScaffoldMessengerKey,
          message: "Une erreur s'est produite, veuillez reéssayer !",
          context: context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneTextController.dispose();
    fullNameTextController.dispose();
    emailTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // userCountryCode =  await userCountryCodeCheck();
    Widget numberWidget() {
      return Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white12,
        ),
        child: TextFormField(
          controller: phoneTextController,
          decoration: InputDecoration(
              errorText: isnumberEnter ? null : "Ce champs est obligatoire",
              fillColor: recovaColor,
              hoverColor: recovaColor,
              hintStyle: const TextStyle(color: Colors.white38),
              labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
              labelText: "Saisissez votre contact",
              hintText: "Téléphone",
              prefixIcon: const Icon(
                Icons.call,
                color: Colors.white54,
              )),
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white, fontSize: 25),
          keyboardType: TextInputType.phone,
          onFieldSubmitted: (String? text) {
            setState(() {
              if (text!.isNotEmpty) {
                isnumberEnter = true;
              } else {
                isnumberEnter = false;
              }
            });

            // emailTextController.text
          },
        ),
      );
    }

    return PageStorage(
      bucket: bucketGlobal,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        home: Scaffold(
          // key: UniqueKey(),
          backgroundColor: recovaColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            backgroundColor: recovaColor,
            centerTitle: true,
            toolbarHeight: 40,
            title: const Text(
              "Création de compte",
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
                          color: Colors.black.withOpacity(0.05),
                          // color: Colors.white.withOpacity(0.15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "E-mail",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white12,
                                // color: Colors.white30,
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                controller: emailTextController,
                                decoration: InputDecoration(
                                    errorText: ismailEnter
                                        ? null
                                        : "Ce champs est obligatoire",
                                    fillColor: recovaColor,
                                    hoverColor: recovaColor,
                                    hintStyle: const TextStyle(
                                        color: Colors.white38, fontSize: 20),
                                    labelStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    labelText: "Saisissez votre adresse e-mail",
                                    hintText: "sample: recova@gmail.com",
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.white54,
                                    )),
                                cursorColor: Colors.white,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                keyboardType: TextInputType.emailAddress,
                                // onSaved: (String? text) {
                                //   print(text);
                                //   // emailTextController.text
                                // },
                                onFieldSubmitted: (String? text) {
                                  setState(() {
                                    if (text!.isEmpty) {
                                      ismailEnter = false;
                                    } else {
                                      ismailEnter = true;
                                    }
                                  });
                                  // emailTextController.text
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Nom et Prenom:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
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
                                autocorrect: false,
                                controller: fullNameTextController,
                                decoration: InputDecoration(
                                    errorText: isnameEnter
                                        ? null
                                        : "Ce champs est obligatoire",
                                    fillColor: recovaColor,
                                    hoverColor: recovaColor,
                                    labelStyle: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    labelText: "Saisissez votre nom complet",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.white54,
                                    )),
                                cursorColor: Colors.white,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                keyboardType: TextInputType.text,
                                onFieldSubmitted: (String? text) {
                                  setState(() {
                                    if (text!.isEmpty) {
                                      isnameEnter = false;
                                    } else {
                                      isnameEnter = true;
                                    }
                                  });
                                  // emailTextController.text
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Contact:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                              builder: (ctx, snapshots) {
                                if (snapshots.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshots.hasError) {
                                    return numberWidget();
                                  } else if (snapshots.hasData) {
                                    final datas = snapshots.data as String;
                                    if (datas.isNotEmpty &&
                                        phoneTextController.text.isEmpty) {
                                      phoneTextController.text = datas;
                                      return numberWidget();
                                    } else {
                                      return Center(
                                        child: numberWidget(),
                                      );
                                    }
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              future: userCountryCodeCheck(),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        elevation: 4.0,
                        shadowColor: recovaColor,
                        // splashColor: Colors.white,
                        child: InkWell(
                          onTap: () {
                            userCreateAccount();
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            // width: 380,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: recovaColor,
                            ),
                            child: InkWell(
                              onTap: () {
                                // print(createAccountIndicator);
                                // if (createAccountIndicator == 2) {
                                //   Navigator.pop(context);
                                // }
                                // Navigator.of(context).popUntil((route){
                                //   print(route.toString());
                                //   return route.toString() == "FirstLoginPage";
                                // });
                                Navigator.of(context)
                                    .popAndPushNamed("FirstLoginPage");

                              },
                              splashColor: recovaMixColor,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: const Center(
                                  child: Text(
                                    "J'ai déjà un compte",
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
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
