import 'dart:async';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/recovaTarifPage.dart';
import 'package:projet_flutter2/userTransactionPage.dart';

import 'ConstantFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_flutter2/UserDataPage.dart';
import 'package:projet_flutter2/UserReportProblemPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';



class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<
      ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userGetOnwerObjectSave();
    final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
    String? isoCountryCode = systemLocales.first.countryCode;
    print(isoCountryCode);
    () async  {pinCodeExist = (await localBdSelectSetting("password") == "yes");
    await userGetOnwerObjectSave();
    if (oneUserDataDico.isEmpty) {
      await getOneUserDataById();
    }
    }();
  }


  void showFooterUserAccountUpdate(BuildContext context, String columnName){
    TextEditingController controller = TextEditingController(text: oneUserDataDico[columnName].toString().isEmpty? userCountryCode: oneUserDataDico[columnName]);
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
        backgroundColor: recovaColor.withOpacity(1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.transparent
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50,),
                Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.mode_edit_outline_rounded,
                          size: 50,
                          color: recovaColor,
                        ),
                      ),
                  ),
                    ),
                  Align(
                    alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close, color: Colors.white))),
                  ]
                ),
                const SizedBox(height: 20,),
                const Divider(height: 30, color: Colors.white,),
                TextFormField(
                  autocorrect: false,
                  controller: controller,
                  autofocus: true,
                  keyboardType: (columnName == "email")? TextInputType.emailAddress: ((columnName == "telephone" || columnName == "telephone2")? TextInputType.phone: TextInputType.name),
                  style: const TextStyle(color:Colors.white),
                ),
                const SizedBox(height: 30,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      child: const Text("Enregistrer", style: TextStyle(color: recovaColor, fontSize: 25),
                      textAlign: TextAlign.center,),
                      onTap: () async {
                        if (columnName == "username" && controller.text.contains(' ')) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Le nom d'utilisateur ne doit pas contenir des espaces", context: context);
                          return;
                        } else if ((columnName == "email") && !(controller.text.contains('@'))) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Adresse mail incorrect", context: context);
                          return;
                        } else if ((columnName == "telephone" || columnName == "telephone2") && !(controller.text.contains('+'))) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Numero de téléphone incorrect", context: context);
                          return;
                        }
                        if (controller.text.isNotEmpty) {
                          pendingPageFunction(context);
                          var status = await userUpdsateAccount(dataMap: {columnName: controller.text});
                          Navigator.of(context).pop();
                          if (status["status"] == "yes") {
                            await getOneUserDataById();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              setState(() {
                              });
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Mise à jour éffectuée avec succès", context: context);
                          } else if (status["status"] == "duplicate username") {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Ce nom d'utilisateur est déjà utilisé", context: context);
                          } else if (status["status"] == "duplicate email") {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "cette adresse email est déjà utilisée", context: context);
                          } else if (status["status"] == "duplicate phone") {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Ce numero de téléphone est déjà utilisé", context: context);
                          } else if (status["message"].toString().contains("must be a valid phone number")) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Le numero de téléphone est incorrect", context: context);
                          } else {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Une erreur s'est produite; veuillez reéssayer", context: context);
                          }
                        }
                      },
                    ),
                  ),
                )
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: Row(
                //     children:  [
                //       const Expanded(
                //         flex: 10,
                //         child: Text("Choisissez votre langue",
                //           style: TextStyle(color: recovaColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20),),
                //       ),
                //       Expanded(
                //           child: IconButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               icon: const Icon(Icons.close, color: recovaColor,)))
                //     ],
                //   ),
                // ),
                // Container(
                //   decoration: const BoxDecoration(
                //     color: Colors.transparent,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       IconButton(onPressed: (){
                //         Navigator.of(context).pop();
                //       }, icon: const Icon(Icons.close, color: Colors.white,))
                //     ],
                //   ),
                // ),
                // // const Divider(height: 70,),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20)
                //   ),
                //   child: InkWell(
                //     splashColor: recovaColor,
                //     highlightColor: recovaColor,
                //     hoverColor: recovaColor,
                //     onTap: (){
                //     },
                //     child: Row(
                //       children: const [
                //         Expanded(
                //             flex: 1,
                //             child: Icon(Icons.circle, size: 15, color: recovaColor,)),
                //         Expanded(
                //           flex: 10,
                //           child: Text("English",
                //             style: TextStyle(color: recovaColor,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 30),),
                //         ),
                //         Expanded(
                //           flex: 1,
                //           child: Icon(Icons.arrow_forward_ios_outlined, size: 15, color: recovaColor),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20,),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20)
                //
                //   ),
                //   child: InkWell(
                //     onTap: (){},
                //     child: Row(
                //       children: const [
                //         Expanded(
                //             flex: 1,
                //             child: Icon(Icons.circle, size: 15, color: recovaColor)),
                //         Expanded(
                //           flex: 10,
                //           child: Text("Français",
                //             style: TextStyle(color: recovaColor,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 30),),
                //         ),
                //         Expanded(
                //           flex: 1,
                //           child: Icon(Icons.arrow_forward_ios_outlined, size: 15, color: recovaColor),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }


  void showFooterUserAccountInfo(BuildContext context){
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
        backgroundColor: recovaColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height - 50,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.transparent
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Center(
                            child: InkWell(
                              onTap: (){
                                // showFooterUserAccountInfo(context);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50.0,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: recovaColor,
                                ),
                              ),
                            ),
                        ),
                          ),
                        Align(
                          alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close, color: Colors.white))),
                        Align(
                          alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.delete_forever, color: Colors.white))),
                        ]
                      ),
                      const Divider(height: 30, color: Colors.white,),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text("Nom d'utilisateur", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                                child: Icon(Icons.alternate_email_rounded, color: Colors.white,)),
                            Expanded(
                              flex: 5,
                                child: Text(oneUserDataDico["username"], style: const TextStyle(color: Colors.white),)),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: (){
                                      showFooterUserAccountUpdate(context, "username");
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.white,))),

                          ],
                        ),
                        const Divider(height: 20, color: Colors.white,),
                        const Text("Nom complet", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                                child: Icon(Icons.person_outline_outlined, color: Colors.white,)),
                            Expanded(
                              flex: 5,
                                child: Text(oneUserDataDico["fullname"], style: const TextStyle(color: Colors.white),)),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: (){
                                      showFooterUserAccountUpdate(context, "fullname");
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.white,))),

                          ],
                        ),
                        const Divider(height: 20, color: Colors.white,),
                        const Text("Adresse mail", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Expanded(
                              flex: 1,
                                child: Icon(Icons.mail_outline_outlined, color: Colors.white,)),
                            Expanded(
                              flex: 5,
                                child: Text(oneUserDataDico["email"], style: const TextStyle(color: Colors.white),)),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: (){
                                      showFooterUserAccountUpdate(context, "email");
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.white,))),

                          ],
                        ),
                        const Divider(height: 20, color: Colors.white,),
                        const Text("Numéro de téléphone", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Visibility(
                          visible: oneUserDataDico["telephone"].toString().isNotEmpty,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                  child: Icon(Icons.phone, color: Colors.white,)),
                              Expanded(
                                flex: oneUserDataDico["telephone2"].toString().isEmpty? 4: 5,
                                  child: Text(oneUserDataDico["telephone"], style: const TextStyle(color: Colors.white),)),
                              Visibility(
                                visible: (oneUserDataDico["telephone2"].toString().isEmpty || oneUserDataDico["telephone2"] == null),
                                replacement: IconButton(
                                    onPressed: (){
                                      showSimpleDialog(title: "Attention",
                                          context: context,
                                          message: "Vous êtes sûr de vouloir supprimer ce numero de téléphone ?",
                                      actionText: "Oui", isimgvisible: true,
                                      onActionTap: () async {
                                       var status = await userDeleteInAccount(culumnName: "telephone");
                                       if (status["status"] == "yes") {
                                         await getOneUserDataById();
                                         Navigator.of(context).pop();
                                         Navigator.of(context).pop();
                                         setState(() {

                                         });
                                         showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                                             message: "Le numero de téléphone a été supprimé avec succès", context: context);
                                       }
                                      });
                                      },
                                    icon: const Icon(Icons.clear, color: Colors.white,)),
                                child: Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: (){
                                          showFooterUserAccountUpdate(context, "telephone2");
                                        },
                                        icon: const Icon(Icons.add, color: Colors.white,))),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: (){
                                        showFooterUserAccountUpdate(context, "telephone");

                                      },
                                      icon: const Icon(Icons.edit, color: Colors.white,))),

                            ],
                          ),
                        ),
                        Visibility(
                          visible: oneUserDataDico["telephone2"].toString().isNotEmpty && oneUserDataDico["telephone2"] != null,
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                  child: Icon(Icons.phone, color: Colors.white,)),
                              Expanded(
                                flex: (oneUserDataDico["telephone2"].toString().isNotEmpty && oneUserDataDico["telephone"].toString().isNotEmpty)? 5: 5,
                                  child: Text((oneUserDataDico["telephone2"].toString().isNotEmpty && oneUserDataDico["telephone2"] != null)? oneUserDataDico["telephone2"]: "", style: const TextStyle(color: Colors.white),)),
                              // Visibility(
                              //   visible: (oneUserDataDico["telephone2"].toString().isNotEmpty && oneUserDataDico["telephone"].toString().isNotEmpty),
                              //   child: Expanded(
                              //       flex: 1,
                              //       child: IconButton(
                              //           onPressed: (){
                              //             showSimpleDialog(title: "Attention",
                              //                 context: context,
                              //                 message: "Vous êtes sûr de vouloir supprimer ce numero de téléphone ?",
                              //                 actionText: "Oui", isimgvisible: true,
                              //                 onActionTap: () async {
                              //                   var status = await userDeleteInAccount(culumnName: "telephone2");
                              //                   if (status["status"] == "yes") {
                              //                     await getOneUserDataById();
                              //                     Navigator.of(context).pop();
                              //                     Navigator.of(context).pop();
                              //                     setState(() {
                              //
                              //                     });
                              //                     showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                              //                         message: "Le numero de téléphone a été supprimé avec succès", context: context);
                              //                   }
                              //                 });
                              //           },
                              //           icon: const Icon(Icons.clear, color: Colors.white,))),
                              // ),
                              Visibility(
                                visible: (oneUserDataDico["telephone"].toString().isEmpty && oneUserDataDico["telephone"] != null),
                                replacement: IconButton(
                                    onPressed: (){
                                      showSimpleDialog(title: "Attention",
                                          context: context,
                                          message: "Vous êtes sûr de vouloir supprimer ce numero de téléphone ?",
                                          actionText: "Oui", isimgvisible: true,
                                          onActionTap: () async {
                                            var status = await userDeleteInAccount(culumnName: "telephone");
                                            if (status["status"] == "yes") {
                                              await getOneUserDataById();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              setState(() {

                                              });
                                              showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                                                  message: "Le numero de téléphone a été supprimé avec succès", context: context);
                                            }
                                          });
                                    },
                                    icon: const Icon(Icons.clear, color: Colors.white,)),
                                child: Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: (){
                                          showFooterUserAccountUpdate(context, "telephone");
                                        },
                                        icon: const Icon(Icons.add, color: Colors.white,))),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: (){
                                        showFooterUserAccountUpdate(context, "telephone2");

                                      },
                                      icon: const Icon(Icons.edit, color: Colors.white,))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: recovaColor,
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // const SizedBox(
                    //   height: 30,
                    // ),
                     Center(
                       child: InkWell(
                        onTap: () async {
                          if ((await localBdSelectSetting("account")) ==
                              "no") {
                            checkUnautoriseUser(context);
                            return;
                          }
                          try {
                            print((oneUserDataDico["telephone2"].toString().isNotEmpty || oneUserDataDico["telephone2"] != null));
                            print(oneUserDataDico["telephone2"].toString().isNotEmpty && oneUserDataDico["telephone2"] != null);
                            print(oneUserDataDico["telephone2"] == null);
                            print(oneUserDataDico["telephone2"] == Null);
                            print("ici la");
                            print(oneUserDataDico);
                            if (oneUserDataDico.isEmpty) {
                              pendingPageFunction(context);
                              await getOneUserDataById();
                              Navigator.of(context).pop();
                              showFooterUserAccountInfo(context);
                            } else
                              showFooterUserAccountInfo(context);
                          } catch (e) {
                            Navigator.of(context).pop();
                            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Une erreur s'est produite", context: context);
                          }
                        },
                        child: const CircleAvatar(
                          backgroundColor: recovaColor,
                          radius: 50.0,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                    ),
                     ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      "@${oneUserDataDico["username"] ?? "Username"}",
                      style: const TextStyle(
                          color: recovaColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: recovaColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Paramètres", Icons.settings,
                            FontWeight.bold, Colors.white, 25.0, () {
                          Navigator.of(context).pushNamed("UserSettingPage");
                        }, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Mes transactions", Icons.pending_actions,
                            FontWeight.bold, Colors.white, 25.0, () {
                                  () async {
                                if (oneUserDataDico.isEmpty) {
                                  await getOneUserDataById();
                                }}();
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => UserTransactionPage(
                              key: UniqueKey(),
                            ),
                          );
                          Navigator.of(context).push(route);
                        }, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Mes données", Icons.perm_data_setting,
                            FontWeight.bold, Colors.white, 25.0, () {
                                  () async {
                                if (oneUserDataDico.isEmpty) {
                                  await getOneUserDataById();
                                }}();
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => UserDataPage(
                              key: UniqueKey(),
                            ),
                          );
                          Navigator.of(context).push(route);
                        }, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption(
                            "Condition d'utilisation",
                            Icons.warning_amber,
                            FontWeight.bold,
                            Colors.white,
                            25.0,
                            () {

                            }, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Guide d'utilisation", Icons.help,
                            FontWeight.bold, Colors.white, 25.0, () {}, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Plan tarifaire", Icons.price_change,
                            FontWeight.bold, Colors.white, 25.0, () {
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => RecoverTarifPage(
                              key: UniqueKey(),
                            ),
                          );
                          Navigator.of(context).push(route);
                        }, context),
                        const SizedBox(
                          height: 40,
                        ),
                        ownSettingOption("Signaler un problème", Icons.report_problem,
                            FontWeight.bold, Colors.white, 25.0, () {
                          var route = MaterialPageRoute(
                            builder: (BuildContext context) => UserReportProblemPage(
                              key: UniqueKey(),
                            ),
                          );
                          Navigator.of(context).push(route);
                        }, context),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget ownSettingOption(String title, IconData icon, FontWeight fontWeight,
    Color color, double size, Function onTap, BuildContext context) {
  return InkWell(
    splashColor: color,
    onTap: () async {
      if ((await localBdSelectSetting("account")) ==
      "no") {
      checkUnautoriseUser(context);
      return;
      }
      onTap();
    },
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Icon(
            icon,
            color: color,
          ),
        ),
        Expanded(
            flex: 5,
            child: Text(
              title,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: size),
            )),
        Expanded(
          flex: 1,
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            color: color,
          ),
        ),
      ],
    ),
  );
}
