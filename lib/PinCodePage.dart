import 'dart:async';
import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:projet_flutter2/UsersSettingPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';
import 'package:projet_flutter2/LocalBdManagerFile.dart';



class CreateUserPinCode extends StatefulWidget {
  const CreateUserPinCode({Key? key, required this.type, this.pinVariable, required this.title, this.state}) : super(key: key);
  final String type;
  final String title;
  final String? pinVariable;
  final Function? state;

  @override
  State<StatefulWidget> createState() => _CreateUserPinCodeState();
}

class _CreateUserPinCodeState extends State<CreateUserPinCode> {
  final StreamController<bool> _verificationNotifier =
  StreamController<bool>.broadcast();
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<
      ScaffoldMessengerState>();

  Future<bool> loginPinCodeVerify(String pinCode) async {
    late Map<String, dynamic> jsonResponse;
    var url = Uri.http(uri, 'user/newLoginPasswordVerify');
    var response = await http.post(url, body: {
      "usernameOrEmailOrPhone": loginContaint,
      "password": pinCode
    });
    if (response.statusCode == 201) {
      jsonResponse = await convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse["status"] == "yes") {
        if (widget.pinVariable == null && widget.type == "UPDATE PIN CODE") {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => CreateUserPinCode(
                key: UniqueKey(), type: "CREATE PIN CODE", title: 'Entrez votre nouveau code PIN', state: widget.state,),
          );
          Navigator.of(context).push(route);
          return true;
        } else if (widget.pinVariable == null && widget.type == "DELETE PIN CODE") {
          var status = await userDeleteInAccount(culumnName: "password");
          if (status["status"] == "yes") {
            await localBdChangeSetting("password", "no");
            await localBdChangeSetting("pinIsRequired", "no");
            widget.state!();
            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Votre code PIN a été supprimé avec succès", context: context);
          } else {
            _verificationNotifier.add(false);
            showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Votre code PIN n'a pas pu être supprimé", context: context);
          }
          Timer(const Duration(seconds: 2), (){
            Navigator.of(context).pop();
            widget.state!();
          });
          return true;
        }
        else {
          print("je suis ici");
          await localBdChangeSetting("account", "yes");
          await localBdChangeSetting("token", jsonResponse["access_token"]);
          Navigator.of(context).popAndPushNamed("RecovaHomePage");
          return true;
        }
      } else if (widget.pinVariable == null && widget.type == "UPDATE PIN CODE") {
        _verificationNotifier.add(false);
        return false;
      } else {
        _verificationNotifier.add(false);
        return false;
      }
    } else {
      _verificationNotifier.add(false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          home: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      colors: [recovaColor, Colors.deepPurple, recovaColor, Colors.white],
                      center: Alignment.bottomRight,
                      radius: 1.5,
                      tileMode: TileMode.decal,
                      stops: [0.1, 0.3, 0.1, 0.1])),
              child: PasscodeScreen(
                isValidCallback: () {
                },
                title: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                ),
                passwordEnteredCallback: _onPasscodeEntered,
                cancelButton: const Text(
                'Cancel',
      style: TextStyle(fontSize: 16, color: Colors.white),),
                deleteButton: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: 'Delete',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.7),
                cancelCallback: _onPasscodeCancelled,
                passwordDigits: 5,
              ),
            ),
          ),
        ),
    );
  }


  _onPasscodeEntered(String enteredPasscode) async {
    if (oneUserDataDico.isEmpty) {
          () async {await getOneUserDataById();}();
    }
    if (widget.pinVariable == null && widget.type == "CREATE PIN CODE") {
      var route = MaterialPageRoute(
        builder: (BuildContext context) => CreateUserPinCode(
          key: UniqueKey(), type: "CREATE PIN CODE 2",
            pinVariable: enteredPasscode, title: "Confirmez votre code PIN", state: widget.state),
      );
      Navigator.of(context).push(route);
    } else  if (widget.pinVariable != null && widget.type == "CREATE PIN CODE 2"){
      if (widget.pinVariable != enteredPasscode) {
        _verificationNotifier.add(false);
      } else {
        var status = await userUpdsateAccount(dataMap: {"password": widget.pinVariable});
        if (status["status"] == "yes") {
          await localBdChangeSetting("password", "yes");
          widget.state!();
          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Votre code PIN a été créé avec succès", context: context);
        Timer(const Duration(seconds: 2,), (){
          Navigator.popUntil(context, (route) {
            return (route.settings.name == "UserSettingPage");
          });
        });
        } else {
          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey, message: "Erreur lors de la création de votre code PIN", context: context);
          Timer(const Duration(seconds: 2,), (){
            Navigator.popUntil(context, (route) => (route.settings.name == "UserSettingPage"));
          });
        }
      }
    } else if (widget.pinVariable == null && widget.type == "VERIFY PIN CODE") {
      loginPinCodeVerify(enteredPasscode);
    } else if (widget.pinVariable == null && (widget.type == "UPDATE PIN CODE" || widget.type == "DELETE PIN CODE")) {
      loginContaint = oneUserDataDico["email"];
      loginPinCodeVerify(enteredPasscode);
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

}