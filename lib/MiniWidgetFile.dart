import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'ConstantFile.dart';
import 'package:flutter/material.dart';


Widget infoObjectPageHead(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
        color: recovaColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      children: [
        const CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.info_outline_rounded, color: recovaColor),),
        const SizedBox(width: 10,),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: recovaColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                textAlign: TextAlign.start,
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Text(
                "Veuillez remplir le formulaire ci-dessous:",
                style: TextStyle(
                  color: Colors.black87,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget pleaseWaitWidget(BuildContext context) {
  return Stack(
    children: [
      Container(
        color: Colors.white,
        child: SpinKitPianoWave(
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
                const Text("Veuillez patienter un instant...", style: TextStyle(fontSize: 15),),
                // Spacer(),
                const SizedBox(height: 20,),
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
                    child: const Text("Annuler", style: TextStyle(color: recovaColor, ), textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],

  );
}