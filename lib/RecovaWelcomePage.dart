import 'dart:async';
// import 'dart:html';
import 'package:projet_flutter2/PinCodePage.dart';
import 'package:projet_flutter2/firebase_service.dart';
import 'package:projet_flutter2/main.dart';

import 'ConstantFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';



class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;


  void navigateToLoginPagePage() =>
      Navigator.of(this.context).popAndPushNamed("FirstLoginPage");
  void navigateToHomePage() =>
      Navigator.of(this.context).popAndPushNamed("RecovaHomePage");

  starTimer() async {
    // return navigateToLoginPagePage();

    print("connecté: ${await hasNetwork()}");
    Duration duration = const Duration(seconds: 1);
    pinIsRequired = (await localBdSelectSetting("pinIsRequired") == "yes");
    if (await localBdSelectSetting("account") == "ys") {
      if (!pinIsRequired) {
        return Timer(duration, navigateToHomePage);
      } else {
        try {
          await getOneUserDataById();
          loginContaint = oneUserDataDico["username"];
          var route = MaterialPageRoute(
            builder: (BuildContext context) => CreateUserPinCode(
                key: UniqueKey(), type: "VERIFY PIN CODE",
                title: "Confirmez votre code PIN"),);
          Timer(duration, (){
            Navigator.of(context).pop(route);
            Navigator.of(context).push(route);
          });
        } catch (e) {
          if (!(await hasNetwork())) {
            print("Desolé vous n'avez aucune connexion internet");
          } else {
            print("Il se peut que vous ne soyez pas connecté à internet");
          }
          print(oneUserDataDico);
          print(e);
        }
      }
    } else {
      print("init");
      try {
        // await AuthService().authAnonyme();
        print("end");
      } catch (e) {
        print(e);
      }
      return navigateToLoginPagePage();

      if (!(await hasNetwork())) {
        showSimpleDialog(title: "RECOVA", context: context,
            message: "Désolé, il semble que vous n'êtes pas connecté à internet !",
        actionText: "Reéssayer", onActionTap: (){
          // setState(() {});
              Navigator.of(context).pop();
              starTimer();
            });
      } else {
        return navigateToLoginPagePage();
      }
    }

    // return Timer(duration, navigateToLoginPagePage);
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstConnection2Db();
    // homePageGetAllObject();
    // userCountryCodeCheck();
    // Toofan
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000),);

    animation = Tween(begin: -0.9, end: 0.9).animate(controller)
      ..addListener(() {setState(() {});});
    starTimer();
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        background(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 155,
                  ),
                  WelcomeMsg(controller, "RECOVA"),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}

Widget WelcomeMsg(AnimationController controller, String txt) {
  return SlideTransition(
    position: Tween<Offset>(
            begin: const Offset(0.0, -1.9), end: const Offset(0.0, 2.0))
        .animate(controller),
    child: Text(
      txt,
      style: const TextStyle(
          color: recovaColor, fontSize: 50, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}

Widget background() {
  return Container(
    decoration: BoxDecoration(gradient: getRG()),
  );
}

// Widget colorbackground() {
//   return Container(
//     color: Colors.black.withOpacity(0.1),
//   );
// }

RadialGradient getRG() {
  return const RadialGradient(
      colors: [recovaColor, Colors.deepPurple, recovaColor, Colors.white],
      center: Alignment.topRight,
      radius: 1.1,
      tileMode: TileMode.mirror,
      stops: [0.1, 0.3, 0.1, 0.1]);
}
