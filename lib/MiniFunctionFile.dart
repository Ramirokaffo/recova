import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projet_flutter2/OtherRecoverObjectPage.dart';
import 'package:projet_flutter2/RecovaFormRetrouvePage.dart';
import 'package:projet_flutter2/childrenRecoverPage.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'ConstantFile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';



Widget transitionWidget() {
  return Container(
    color: Colors.white,
    child: SpinKitPianoWave(
      // color: recovaColor,
      size: 100,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? recovaColor : recovaColor,
          ),
        );
      },
    ),
  );
}


Future showWaitTransitionWidget(BuildContext context) async {
  return await showDialog(context: context, builder: (context) {
    // Timer(Duration(seconds: 3), (){Navigator.of(context).pop();});
    return Container(
      color: Colors.white,
      child: SpinKitPianoWave(
        // color: recovaColor,
        size: 100,
        itemBuilder: (BuildContext context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? recovaColor : recovaColor,
            ),
          );
        },
      ),
    );});}


Future waitSendingDataWidget(BuildContext context) {
  return showDialog(context: context, builder: (context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: SpinKitThreeInOut(
            // color: recovaColor,
            size: 100,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? recovaColor : Colors.white,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + 80,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: SizedBox(
            width: 200,
            child: Material(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("En cours d'envoi...", style: TextStyle(fontSize: 20),),
                  // Spacer(),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: recovaColor)
                      ),
                      // height: 50,
                      child: Text("Annuler", style: TextStyle(color: recovaColor, ), textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],

    );});}


Future pendingPageFunction(BuildContext context) {
  return showDialog(context: context, builder: (context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: SpinKitCircle(
            // color: recovaColor,
            size: 100,
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? recovaColor : Colors.white,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + 80,
          left: MediaQuery.of(context).size.width / 2 - 100,
          child: SizedBox(
            width: 200,
            child: Material(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("En cours d'envoi...", style: TextStyle(fontSize: 20),),
                  // Spacer(),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                          // border: Border.all(width: 1, color: recovaColor)
                      ),
                      // height: 50,
                      child: Text("Annuler", style: TextStyle(color: recovaColor, ), textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],

    );});}


Widget transitionWidget2({Color color = recovaColor}) {
  return SpinKitThreeBounce(
    // color: recovaColor,
    size: 50,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? color : color,
        ),
      );
    },
  );
}


Widget miniTransitionWidget() {
  return SpinKitDoubleBounce(
    size: 15,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? recovaColor : recovaColor,
        ),
      );
    },
  );
}


void showFooterActionPerdu(BuildContext context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 2 / 4,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    flex: 10,
                    child: Text(
                      "Qu'est-ce que vous recherchez ?",
                      style: TextStyle(
                          color: recovaColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: recovaColor,
                          )))
                ],
              ),
              const Divider(
                height: 50,
                color: recovaColor,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.circle, color: recovaColor,),
                title: const Text("Un objet", style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
                subtitle: const Text("Pièce personnelle & Document officiel"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const RecovaLostThingForm()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle, color: recovaColor,),
                title: const Text("Enfant égaré", style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const RecovaLostThingForm()));
                },
              ),
            ],
          ),
        );
      });
}


void showFooterActionRetrouve(BuildContext context) {
  showModalBottomSheet(

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 3 / 4,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    flex: 10,
                    child: Text(
                      "Qu'est-ce que vous avez retrouvé ?",
                      style: TextStyle(
                          color: recovaColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: recovaColor,
                          )))
                ],
              ),
              const Divider(
                height: 50,
                color: recovaColor,
              ),
              // oneOptionToShow(
              //     title: "Un objet",
              //     onTap: () {
              //         Navigator.pop(context);
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (context) =>
              //                 const RecovaRecoverThingForm()));
              //     }),
              ListTile(
                leading: const Icon(Icons.circle, color: recovaColor,),
                title: const Text("Un objet", style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
                subtitle: const Text("Pièce personnelle & Document officiel"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const RecovaRecoverThingForm()));
                },
              ),


              // oneOptionToShow(title: "Un enfant égaré", onTap: () {
              //   Navigator.pop(context);
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) =>
              //       const RecovaChildrenPage()));
              // }),
              ListTile(
                leading: const Icon(Icons.circle, color: recovaColor,),
                title: const Text("Un enfant égaré", style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
                // subtitle: const Text("Colis, Sac de voyage"),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const RecovaChildrenPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle, color: recovaColor,),
                title: const Text("Autres", style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
                subtitle: const Text("Collis, Sac de voyage..."),
                trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                      const OtherRecoverObjectPage()));
                },
              ),
              // oneOptionToShow(title: "Autres(Colis, Sac de voyage", onTap: () {
              //   Navigator.pop(context);
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) =>
              //       const OtherRecoverObjectPage()));
              // }),
            ],
          ),
        );
      });
}


void addRecoverOrLoseObject(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 2 / 4,
          decoration: const BoxDecoration(
            color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20))),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    color: Colors.red,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                        shadows: [Shadow(color: recovaColor, offset: Offset(0.1, 0.8), blurRadius: 1)],
                      ))
                ],
              ),
              const Divider(
                height: 20,
                color: recovaColor,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: recovaColor
                ),
                child: ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white,),
                  title: const Text("J'ai retrouvé", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  // subtitle: const Text("Pièce personnelle & Document officiel"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
                  onTap: (){
                    Navigator.pop(context);
                    showFooterActionRetrouve(context);
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: recovaColor
                ),
                child: ListTile(
                  leading: const Icon(Icons.circle, color: Colors.white,),
                  title: const Text("J'ai perdu", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                  // subtitle: const Text("Pièce personnelle & Document officiel"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
                  onTap: (){
                    Navigator.pop(context);
                    showFooterActionPerdu(context);
                  },
                ),
              ),

            ],
          ),
        );
      });

}


Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
  return null;
}
