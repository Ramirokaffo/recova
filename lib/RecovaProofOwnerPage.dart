import 'package:flutter/material.dart';
import 'package:projet_flutter2/DisplayImage.dart';
import 'package:projet_flutter2/RecovaFormPerduPage.dart';
import 'ConstantFile.dart';
import 'dart:io';



class RecovaProofOwnerWidget extends StatefulWidget {
  const RecovaProofOwnerWidget({Key? key}) : super(key: key);

  @override
  _RecovaProofOwnerWidgetState createState() => _RecovaProofOwnerWidgetState();
}

class _RecovaProofOwnerWidgetState extends State<RecovaProofOwnerWidget> {

  Widget spendingWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  const <Widget>[
          SizedBox(height: 200,),
          Text("Vous pouvez rechercher avec l'une des entrées suivantes:",
            style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold),),
          Text("   Le nom de l'objet", style: TextStyle(color: recovaColor)),
          Text("   Le numero, l'identifiant ou le matricule de l'objet", style: TextStyle(color: recovaColor)),
          Text("   Le nom de l'enfant s'il s'agit d'un enfant", style: TextStyle(color: recovaColor)),
          SizedBox(height: 30,),
          Text("NB: La recherche vous permet de savoir si l'objet que vous avez "
              "perdu a été retrouvé ou bien l'objet que vous avez retrouvé a déjà été déclaré perdu"
              , style: TextStyle(color: recovaColor)),
          // Center(
          //   child: Container(
          //     color: Colors.transparent,
          //       child: Image.asset("images/41.gif", colorBlendMode: BlendMode.color,)),
          // )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void refreshImage(BuildContext context) {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Stack(children: [
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: () {
                  var route = MaterialPageRoute(
                    builder: (BuildContext context) => DisplaysImage(
                      key: UniqueKey(),
                      image: objectImageData["path"]!,
                      islocal: true,
                    ),
                  );
                  Navigator.of(context).push(route);
                },
                child: Image.file(
                  File(objectImageData["path"]!),
                  // width: double.infinity,
                  // height: double.infinity,
                  fit: BoxFit.contain,
                ),
              )),
          Positioned(
              bottom: 5,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: recovaColor,
                  ),
                  onPressed: () {
                    showFooterActionImagePerduChoice(context: context, refreshParentState: refreshImage);
                  },
                ),
              )),
        ]),
      ],
    );
  }
}
