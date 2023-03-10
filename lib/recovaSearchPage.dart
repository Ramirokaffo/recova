import 'package:flutter/material.dart';
import 'package:projet_flutter2/main.dart';
import 'ConstantFile.dart';
import 'package:projet_flutter2/OneObjectDataShowPage.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'package:projet_flutter2/RoutesFile.dart';


class RecovaSarchWidget extends StatefulWidget {
  const RecovaSarchWidget({Key? key}) : super(key: key);

  @override
  _RecovaSarchWidgetState createState() => _RecovaSarchWidgetState();
}

TextEditingController searchTextController = TextEditingController();

class _RecovaSarchWidgetState extends State<RecovaSarchWidget> {
  int controlEmptySearch = 0;


  Future onResearchChanged(String text) async  {
    if (text.isNotEmpty) {
      var jsonResponse = await getAllSearchObject(text);
      setState(() {
        controlEmptySearch = 1;
        objectSearchList = jsonResponse as List;
        if (objectSearchList.isEmpty) {
          setState(() {
            objectSearchList = [{"objectType": "%none%-"}];
          });
        }
      });
    } else {
      setState(() {

        objectSearchList = objectSearchList;
        controlEmptySearch = 0;

        // objectSearchList.clear();
      });
    }
  }
  Widget noResultWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 100,),
        errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/8516dec954b578b3b15def9f672e9930.jpg",
            context: context, message: "Aucun résultat correspondant aux termes saisis", buttonIsVisible: false, scale: 1),
      ],
    );
  }


  Widget spendingWidget() {
    return Column(
      children: [
        // const SizedBox(height: 50,),
        Center(
           child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/b3311d7b4caee74ea8e64778e193ab38.jpg",
               context: context, message: "Entrez du texte pour rechercher", buttonIsVisible: false, scale: 1),
            // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children:  const <Widget>[
          //     SizedBox(height: 200,),
          //     Text("Vous pouvez rechercher avec l'une des entrées suivantes:",
          //       style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold),),
          //     Text("   Le nom de l'objet", style: TextStyle(color: recovaColor)),
          //     Text("   Le numero, l'identifiant ou le matricule de l'objet", style: TextStyle(color: recovaColor)),
          //     Text("   Le nom de l'enfant s'il s'agit d'un enfant", style: TextStyle(color: recovaColor)),
          //     SizedBox(height: 30,),
          //     Text("NB: La recherche vous permet de savoir si l'objet que vous avez "
          //         "perdu a été retrouvé ou bien l'objet que vous avez retrouvé a déjà été déclaré perdu"
          //         , style: TextStyle(color: recovaColor)),
          //     // Center(
          //     //   child: Container(
          //     //     color: Colors.transparent,
          //     //       child: Image.asset("images/41.gif", colorBlendMode: BlendMode.color,)),
          //     // )
          //   ],
          // ),
        ),
      ],
    );
  }


  Widget SearchSection() {
    return Column(
      children: [
        Container(
          height:80,
          decoration: const BoxDecoration(
            color: recovaColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                const SizedBox(width: 5,),
                Expanded(
                  flex: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 38,
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 3),
                      child: TextField(
                        autofocus: true,
                        enabled: true,
                        controller: searchTextController,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          focusColor: Colors.red,
                          filled: false,
                          hintText: "Rechercher",
                          hintStyle: TextStyle(color: recovaColor),
                        ),
                        cursorColor: recovaColor,
                        style: const TextStyle(color: recovaColor),
                        onChanged: (text) async {
                          onResearchChanged(text);
                        },
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                    child: CircleAvatar(
                      child: Material(
                        elevation: 2,
                        color: recovaColor,
                        child: IconButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.cancel, color: Colors.white)),
                      ),
                    ))
              ],
            ),
          ),
        ),
        const Divider(height: 20, color: recovaColor),

      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      objectSearchList = [{"objectType": "%wait%-"}];
    });
  }



  // @override
  // Widget build(BuildContext context) {
  //   return
  //     // Scaffold(
  //     // appBar: AppBar(
  //     //   title: const Text('DraggableScrollableSheet'),
  //     // ),
  //     // body:
  //     DraggableScrollableSheet(
  //       maxChildSize: 0.8,
  //       expand: false,
  //       builder: (BuildContext context, ScrollController scrollController) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: Colors.blue[100],
  //           ),
  //           // color: Colors.blue[100],
  //           child: ListView.builder(
  //             controller: scrollController,
  //             itemCount: 25,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ListTile(title: Text('Item $index'));
  //             },
  //           ),
  //         );
  //       },
  //     );
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SearchSection(),
        Expanded(
          flex: 10,
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              // physics: const BouncingScrollPhysics(
              //   // parent: AlwaysScrollableScrollPhysics()
              // ),
              itemCount: objectSearchList.isEmpty ? 0 : objectSearchList.length,
              itemBuilder: (context, val) {
                if ((controlEmptySearch == 0 || controlEmptySearch == 2) && (objectSearchList[val]["objectType"] != "%wait%-")) {
                  if (controlEmptySearch == 0) {
                    controlEmptySearch = 2;
                    return spendingWidget();
                  } else {
                    return const SizedBox(height: 0.1,);
                  }

                } else if (objectSearchList[val]["objectType"] == "%wait%-") {
                  return spendingWidget();
                } else if (objectSearchList[val]["objectType"] == "%none%-") {
                  return noResultWidget();
                }
                return ListTile(
                  title: Text(
                    objectSearchList[val]["type"] == "Autres"? objectSearchList[val]["otherType"]: objectSearchList[val]["type"],
                    style: const TextStyle(
                        color: recovaColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: recovaColor,
                  ),
                  subtitle: Text(
                    (objectSearchList[val]["objectName"])!,
                    style: const TextStyle(color: recovaColor),
                  ),
                  onTap: () {
                    print(objectSearchList[val]);
                    print(objectSearchList[val]["nowSide"] == null);
                    // return;
                    var route = MaterialPageRoute(
                      builder: (BuildContext context) => SecondePage(
                        key: UniqueKey(),
                        recover_object_id: val,ojectList: objectSearchList,
                      ),
                    );
                    Navigator.of(context).push(route);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
