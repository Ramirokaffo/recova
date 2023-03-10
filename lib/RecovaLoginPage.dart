import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';
import 'package:projet_flutter2/PinCodePage.dart';
import 'package:projet_flutter2/firebase_service.dart';
import 'package:projet_flutter2/main.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/CreateAccountFormPage.dart';
import 'package:projet_flutter2/UsersSettingPage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class FirstLoginPage extends StatefulWidget {
  const FirstLoginPage({Key? key, BuildContext? context}) : super(key: key);

  @override
  _FirstLoginPageState createState() => _FirstLoginPageState();
}

class _FirstLoginPageState extends State<FirstLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  TextEditingController loginTextController = TextEditingController();

  void navigatorToPricipalPage() =>
      Navigator.of(context).popAndPushNamed("RecovaHomePage");

  Future<bool> loginAccountCheck(String login) async {
    int? isnumber = int.tryParse(login);
    if (!login.startsWith("+") && (isnumber != null)) {
      login = userCountryCode + login;
    }
    late Map<String, dynamic> jsonResponse;
    var url = Uri.http(uri, 'user/loginAccountCheck');
    var response =
        await http.post(url, body: {"usernameOrEmailOrPhone": login});

    if (response.statusCode == 201) {
      jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == "yes") {
        if (jsonResponse["password"] == "yes") {
          loginContaint = login;
          var route = MaterialPageRoute(
            builder: (BuildContext context) => CreateUserPinCode(
                key: UniqueKey(),
                type: "VERIFY PIN CODE",
                title: "Confirmez votre code PIN"),
          );
          Navigator.of(context).push(route);
          return true;
        } else {
          await localBdChangeSetting("account", "yes");
          await localBdChangeSetting("token", jsonResponse["access_token"]);
          var route = MaterialPageRoute(
            builder: (BuildContext context) => RecovaHomePage(key: UniqueKey()),
          );
          Navigator.of(context).push(route);
          Navigator.of(context).popAndPushNamed("RecovaHomePage");
          return true;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    animation = Tween(begin: 0.0, end: 0.9).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      home: StreamBuilder<User?>(
        stream: AuthService().userChange,
          builder: (context, snapshot) {
          print(snapshot.data);
        return Scaffold(
          body: Center(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(gradient: getLG()),
                ),
                colorbackground(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(
                      children: <Widget>[
                        const SizedBox(
                          height: 80.0,
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0.0, -0.9),
                                  end: Offset.zero)
                              .animate(controller),
                          child: Container(
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            //     border: BoxBorder.lerp(Border.all(color: recovaColor, width: 0.8), Border.all(color: recovaColor), 3),
                            //     color: Colors.white
                            // ),
                            child: TextField(
                              autocorrect: false,
                              toolbarOptions: const ToolbarOptions(
                                  copy: true,
                                  cut: true,
                                  paste: true,
                                  selectAll: true),
                              selectionWidthStyle: BoxWidthStyle.tight,
                              selectionHeightStyle:
                                  BoxHeightStyle.includeLineSpacingMiddle,
                              controller: loginTextController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: recovaColor, width: 20)),
                                helperText: "Email/téléphone/username",
                                fillColor: recovaColor,
                                hoverColor: recovaColor,
                                helperStyle: TextStyle(color: recovaColor),
                                hintStyle:
                                    TextStyle(color: recovaColor, fontSize: 15),
                                labelStyle:
                                    TextStyle(color: recovaColor, fontSize: 23),
                                labelText: "Vous avez déjà un compte ?",
                                hintText: "Entrez votre login",
                                icon: Icon(
                                  Icons.lock,
                                  color: recovaColor,
                                ),
                              ),
                              cursorColor: recovaColor,
                              style: const TextStyle(
                                  color: recovaMixColor,
                                  fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0.0, -0.9),
                                  end: Offset.zero)
                              .animate(controller),
                          child: WhitebuttonInfo("Connexion à mon compte",
                              () async {
                            if (loginTextController.text.isEmpty) {
                              showSimpleSnackbar(
                                  rootScaffoldMessengerKey:
                                      rootScaffoldMessengerKey,
                                  message:
                                      "Veuillez entrer votre login (Adresse email, "
                                      "numero de telephone ou nom d'utilisateur) si vous avez déjà un compte",
                                  context: context);
                              return;
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => pleaseWaitWidget(context),
                            ));
                            bool accountExist = await loginAccountCheck(
                                loginTextController.text);
                            //ramirokaffo@gmail.com
                            Navigator.pop(context);
                            if (!accountExist) {
                              showSimpleSnackbar(
                                  rootScaffoldMessengerKey:
                                      rootScaffoldMessengerKey,
                                  message:
                                      "Aucun compte RECOVA ne correspond à ce login !",
                                  context: context);
                            }
                          }, context),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(0.0, -0.9),
                                  end: Offset.zero)
                              .animate(controller),
                          child: WhitebuttonInfo("Créer un compte", () {
                            createAccountIndicator = 2;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountPage()));
                          }, context),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0.0, -0.6),
                                    end: Offset.zero)
                                .animate(controller),
                            child: WhitebuttonInfo("Continuer sans compte",
                                navigatorToPricipalPage, context),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                                    begin: const Offset(0.0, -0.6),
                                    end: Offset.zero)
                                .animate(controller),
                            child: InkWell(
                              onTap: () {
                                showFooterUserLanguageChoice(context);
                              },
                              splashColor: recovaMixColor,
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  "Changer de langue",
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
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget WhitebuttonInfo(String text, Function onTap, BuildContext context) {
  return Material(
    borderRadius: BorderRadius.circular(25),
    color: recovaColor,
    elevation: 4.0,
    shadowColor: recovaColor,
    child: InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: BoxBorder.lerp(Border.all(color: recovaColor, width: 0.8),
                Border.all(color: recovaColor), 3),
            color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: recovaColor,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ),
  );
}

Widget background(String img) {
  return Container(
    decoration: BoxDecoration(gradient: getLG()),
  );
}

LinearGradient getLG() {
  return const LinearGradient(
    colors: [
      Color(0xFFFFFFFF),
      recovaColor,
      Color(0xff0498f8),
      recovaColor,
    ],
    begin: FractionalOffset(0.9, 0.1),
    end: Alignment.bottomCenter,
    stops: [0.1, 0.9, 0.1, 0.1],
    tileMode: TileMode.clamp,
  );
}

Widget colorbackground() {
  return Container(
    color: Colors.black.withOpacity(0.2),
  );
}
