import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/UsersAccountPage.dart';
import 'package:projet_flutter2/PinCodePage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';


class UserSettingPage extends StatefulWidget {
  UserSettingPage({Key? key}) : super(key: key);

  @override
  _UserSettingPage createState() => _UserSettingPage();
}

class _UserSettingPage extends State<UserSettingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateToRefresh();
  }

  void stateToRefresh() {
    setState(() {
      () async {
        pinCodeExist = (await localBdSelectSetting("password") == "yes");
        pinIsRequired = (await localBdSelectSetting("pinIsRequired") == "yes");
      }();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Paramètres",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: recovaColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Préférences",
                style: TextStyle(
                    color: recovaColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(
                height: 40,
              ),
              ownSettingOption("Changer de langue", Icons.language_outlined,
                  FontWeight.normal, recovaColor, 18.0, () {
                showFooterUserLanguageChoice(context);
              }, context),
              const Divider(
                height: 40,
              ),
              const SizedBox(height: 20),
              const Text(
                "Sécurité",
                style: TextStyle(
                    color: recovaColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Visibility(
                visible: !pinCodeExist,
                child: Column(
                  children: [
                     const Divider(
                      height: 30,
                    ),
                    ownSettingOption("Créer un code PIN", Icons.lock,
                        FontWeight.normal, recovaColor, 18.0, () {
                          if (oneUserDataDico.isEmpty) {
                                () async {await getOneUserDataById();}();
                          }
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) => CreateUserPinCode(
                            key: UniqueKey(),
                            type: "CREATE PIN CODE",
                            title: 'Entrez votre code PIN',
                            state: stateToRefresh),
                      );
                      Navigator.of(context).push(route);
                    }, context),
                  ],
                ),
              ),
              Visibility(
                visible: pinCodeExist,
                child: Column(
                  children: [
                    const Divider(height: 30,),

                    ownSettingOption("Modifier le code PIN", Icons.update,
                        FontWeight.normal, recovaColor, 18.0, () {
                          if (oneUserDataDico.isEmpty) {
                                () async {await getOneUserDataById();}();
                          }
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) => CreateUserPinCode(
                            key: UniqueKey(),
                            type: "UPDATE PIN CODE",
                            title: 'Entrez votre code PIN actuel',
                            state: stateToRefresh),
                      );
                      Navigator.of(context).push(route);
                    }, context),
                  ],
                ),
              ),
              Visibility(
                visible: pinCodeExist,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ownSettingOption("Supprimer le code PIN", Icons.delete,
                        FontWeight.normal, recovaColor, 18.0, () async {
                          if (oneUserDataDico.isEmpty) {
                                () async {await getOneUserDataById();}();
                          }
                      showSimpleDialog(
                          title: "RECOVA",
                          context: context,
                          message:
                              "Vous êtes sûr de vouloir supprimer votre code PIN?",
                          isimgvisible: true,
                          actionText: "Oui",
                          onActionTap: () {
                            Navigator.of(context).pop();
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateUserPinCode(
                                      key: UniqueKey(),
                                      type: "DELETE PIN CODE",
                                      title: 'Entrez votre code PIN actuel',
                                      state: stateToRefresh),
                            );
                            Navigator.of(context).push(route);
                          });
                    }, context),
                    const SizedBox(height: 25,),
                    Visibility(
                      visible: pinCodeExist,
                      child: SwitchListTile(value: pinIsRequired, onChanged: (bool status) async {
                        if (!pinIsRequired) {
                          await localBdChangeSetting("pinIsRequired", "yes");
                        } else {
                          await localBdChangeSetting("pinIsRequired", "no");
                        }
                        setState(() {
                          pinIsRequired = !pinIsRequired;
                        });
                      }, activeColor: recovaColor,
                        dense: true,
                        secondary: const Icon(Icons.security, color: recovaColor),
                        title: const Text("Exiger le code PIN au login",
                          style: TextStyle(color: recovaColor, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,),
                        // subtitle: Text("Yaoundé"),
                        ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}

void showFooterUserLanguageChoice(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: recovaColor.withOpacity(0.9),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.transparent),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
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
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              // const Divider(height: 70,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  splashColor: recovaColor,
                  highlightColor: recovaColor,
                  hoverColor: recovaColor,
                  onTap: () {},
                  child: Row(
                    children: const [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.circle,
                            size: 15,
                            color: recovaColor,
                          )),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "English",
                          style: TextStyle(
                              color: recovaColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios_outlined,
                            size: 15, color: recovaColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Expanded(
                          flex: 1,
                          child:
                              Icon(Icons.circle, size: 15, color: recovaColor)),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Français",
                          style: TextStyle(
                              color: recovaColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.arrow_forward_ios_outlined,
                            size: 15, color: recovaColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
