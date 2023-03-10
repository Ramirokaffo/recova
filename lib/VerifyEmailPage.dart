import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/MiniWidgetFile.dart';
import 'package:projet_flutter2/firebase_service.dart';

class VerifyEmailPage extends StatefulWidget {
  final String? phoneNumber;
  final String email;

  const VerifyEmailPage({
    Key? key,
    this.phoneNumber, required this.email
  }) : super(key: key);

  @override
  _VerifyEmailPageState createState() =>
      _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  TextEditingController textEditingController = TextEditingController();
  // FirebaseUser user;
  // ..text = "123456";
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  bool isEmailVerify = false;
  User? user = FirebaseAuth.instance.currentUser;
  late StreamSubscription userChange;


  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userChange = FirebaseAuth.instance.userChanges().listen((usr) {
      setState(() {
        user = usr;
      });
    });
    try {
      isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    } catch (e) {
      //
    }
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget verifiedPage2() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: recovaColor,
          title: Text("Sécurité", style: TextStyle(color: Colors.white, fontSize: 25),),),
        body: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Icon(Icons.lock, size: 200, color: recovaColor,),
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Verification de l'adresse e-mail",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: recovaColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                  child: RichText(
                    text: TextSpan(
                        text: "Entrez le code envoyé à cette adreese: ",
                        children: [
                          TextSpan(
                              text: "${widget.phoneNumber}",
                              style: const TextStyle(
                                  color: recovaColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ],
                        style:
                        const TextStyle(color: recovaMixColor, fontSize: 13)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: recovaColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        obscuringWidget: const FlutterLogo(
                          size: 24,
                        ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.scale,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "Code incorrect";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveFillColor: Colors.white,
                          inactiveColor: recovaColor,
                          selectedFillColor: recovaColor,
                          activeColor: recovaColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Le code que vous avez saisi est incorrect" : "",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous n'avez pas reçu le code? ",
                      style: TextStyle(color: recovaMixColor, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => snackBar("Un nouveau code a été renvoyé !!"),
                      child: const Text(
                        "renvoyer",
                        style: TextStyle(
                            color: recovaColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                  decoration: BoxDecoration(
                      color: recovaColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: const Offset(1, -2),
                            blurRadius: 5),
                        BoxShadow(
                            color: Colors.green.shade200,
                            offset: const Offset(-1, 2),
                            blurRadius: 5)
                      ]),
                  child: ButtonTheme(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.length != 6 || currentText != "123456") {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                            textEditingController.clear();
                          });
                        } else {
                          setState(
                                () {
                              hasError = false;
                              snackBar("OTP Verified!!");
                            },
                          );
                        }
                      },
                      child: Center(
                          child: Text(
                            "Vérifier".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                        child: TextButton(
                          child: const Text("Effacer", style: TextStyle(color: recovaColor),),
                          onPressed: () {
                            textEditingController.clear();
                          },
                        )),
                    Flexible(
                        child: TextButton(
                          child: const Text("Coller du texte", style: TextStyle(color: recovaColor),),
                          onPressed: () {
                            setState(() {
                              textEditingController.text = "123456";
                            });
                          },
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget verifiedPage() {
      return MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context, false);
            }, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
            backgroundColor: recovaColor,
            title: const Text("Vérification", style: TextStyle(color: Colors.white, fontSize: 25),),),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25,),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: recovaColor, width: 1),
                        color: Colors.brown.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: recovaColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.info_outline, color: recovaColor,),),
                            )),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: recovaColor.withOpacity(0.9)
                            ),
                            child: Text("Un lien de vérification a été envoyé a cette adresse: ${widget.email}",
                                style: const TextStyle(color: Colors.black, fontSize: 20), textAlign: TextAlign.justify,),
                          ),),
                        // const Expanded(
                        //   flex: 2,
                        //   child: Text("Veuillez consulter votre boite mail !",
                        //       style: TextStyle(color: Colors.black, fontSize: 25), textAlign: TextAlign.center,),
                        // )

                      ],
                    ),
                  ),
                  // const SizedBox(height: 10,),
                  const Text("Consulter votre boîte mail et cliquez sur le lien !",
                    style: TextStyle(color: Colors.black, fontSize: 15), textAlign: TextAlign.justify,),
                  const SizedBox(height: 30,),
                  InkWell(
                    child: const Text("Je n'ai pas reçu le lien ! Renvoyer ?",
                      style: TextStyle(color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,),
                    onTap: (){
                      AuthService().sendVerificationEmail();
                      showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                          message: "Un nouveau lien de validation a été renvoyé !", context: context);
                    },
                  ),

                  const SizedBox(height: 80,),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: recovaColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 1)],
                      ),
                      child: const Text("Confirmation", style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,),
                    ),
                    onTap: () async {
                      // print(user);
                      try {
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => pleaseWaitWidget(context),
                      ));
                      await FirebaseAuth.instance.currentUser!.reload();
                      Navigator.pop(context);
                      // print(user);
                      // return;
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          Navigator.of(context).pop(true);
                        } else {
                          showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                              message: "Vous n'avez pas confirmer votre adresse e-mail !", context: context);
                          return;
                        }
                        // isEmailVerify = FirebaseAuth.instance.currentUser!.emailVerified;
                      } catch (e) {
                        Navigator.pop(context);
                        showSimpleSnackbar(rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                            message: "Une erreur s'est produite !", context: context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }


    return verifiedPage();
  }
}