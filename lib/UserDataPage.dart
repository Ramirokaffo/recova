import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/MiniFunctionFile.dart';
import 'package:projet_flutter2/SaveMyDataFormPage.dart';
import 'package:projet_flutter2/UsersAccountPage.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:projet_flutter2/main.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';



class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key, BuildContext? context}) : super(key: key);

  @override
  _UserDataPage createState() => _UserDataPage();
}

class _UserDataPage  extends State<UserDataPage> {

  @override
  void initState() {
    super.initState();
  }


  void refreshState() {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    List<GlobalKey<SimpleFoldingCellState>> listFoldingCellKey = List<GlobalKey<SimpleFoldingCellState>>.generate(userObjectSaveList.length, (index) => GlobalKey<SimpleFoldingCellState>());

    Widget _buildFrontWidget(GlobalKey<SimpleFoldingCellState> foldingCellkey, String title) {
      return Material(
        elevation: 20,
        child: InkWell(
          onTap: ()=> foldingCellkey.currentState?.toggleFold(),
          child: Container(

            decoration: BoxDecoration(
              border: BoxBorder.lerp(
                  const Border(
                      top: BorderSide(
                          color: recovaColor),
                      bottom: BorderSide(
                          color: recovaColor),
                  left: BorderSide(
                      color: recovaColor),
                  right: BorderSide(
                      color: recovaColor)),
                  const Border(
                      top: BorderSide(
                      color: recovaColor),
                      bottom: BorderSide(
                          color: recovaColor),
                  left: BorderSide(
                      color: recovaColor),
                  right: BorderSide(
                      color: recovaColor)), 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            // color: recovaColor,
            // alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                 Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(color: recovaColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildInnerWidget(GlobalKey<SimpleFoldingCellState> foldingCellkey, dynamic data) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
            border: BoxBorder.lerp(
                const Border(
                    top: BorderSide(
                        color: recovaColor),
                    bottom: BorderSide(
                        color: recovaColor),
                    left: BorderSide(
                        color: recovaColor),
                    right: BorderSide(
                        color: recovaColor)),
                const Border(
                    top: BorderSide(
                        color: recovaColor),
                    bottom: BorderSide(
                        color: recovaColor),
                    left: BorderSide(
                        color: recovaColor),
                    right: BorderSide(
                        color: recovaColor)), 1),
            color: Colors.black.withOpacity(0.01),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          children: [
             Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    color: recovaColor,
                    child: Center(
                      child: Text(
                        objectIdToName[data["objectSaveTypeId"]]!,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nom: ${oneUserDataDico["fullname"]}',
                    style: const TextStyle(color: recovaColor, fontSize: 15),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    'ID: ${data["objectNumber"]}',
                    style: const TextStyle(color: recovaColor, fontSize: 15),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   right: 1,
            //   bottom: 1,
            //   child: IconButton(
            //       onPressed: () => folding_cellkey.currentState?.toggleFold(),
            //       icon: const Icon(Icons.close, color: recovaColor,))
            // ),
            // Positioned(
            //   left: 1,
            //   bottom: 1,
            //   child: IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.edit, color: recovaColor,))
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: recovaColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.white,)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete, color: Colors.white,)),

                    IconButton(
                        onPressed: () => foldingCellkey.currentState?.toggleFold(),
                        icon: const Icon(Icons.close, color: Colors.white,))
                  ],
                ),
              )
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.delete, color: recovaColor,)),
            )
          ],
        ),
      );
    }

    Widget addObjectWidget() {
      return InkWell(
        splashColor: recovaColor,
        onTap: () async {
          pendingPageFunction(context);
          await newGetAllObjectType();
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaveMyDataFormPage(refreshState: refreshState,),));
        },
        child: Column(
          children: [
            const SizedBox(height: 5,),
            Container(
              width: 150,
              height: 100-2,
              decoration: BoxDecoration(
                border: BoxBorder.lerp(
                    const Border(
                      bottom: BorderSide(
                          color: recovaColor),
                    ),
                    const Border(
                      bottom: BorderSide(
                          color: recovaColor),
                    ), 1
                ),
                color: Colors.white,
              ),
              child: Stack(
                children: const <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.add, color: recovaColor, size: 50,)
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget listUserObjectSave() {
      Widget ownObjectWidget(List<dynamic> data, int index) {
        return SimpleFoldingCell.create(
          padding: const EdgeInsets.all(5),
          borderRadius: 10,
          key: listFoldingCellKey[index],
          frontWidget: _buildFrontWidget(listFoldingCellKey[index], objectIdToName[data[index]["objectSaveTypeId"]]!),
          innerWidget: Column(
            children: [
              _buildInnerWidget(listFoldingCellKey[index], data[index])
            ],
          ),
          cellSize: Size(MediaQuery
              .of(context)
              .size
              .width, 100),
        );
      }

      return FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.done) {
            if (snapshot.hasError) {
              return  Center(
                child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                    context: context),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data as List<dynamic>;
              listFoldingCellKey = List<GlobalKey<SimpleFoldingCellState>>.generate(data.length, (index) => GlobalKey<SimpleFoldingCellState>());
              if (data.isNotEmpty) {
                return MasonryGridView.count(
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 1,
                  crossAxisCount: 2,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: data.length ,
                  itemBuilder: (BuildContext context, int index){
                      return ownObjectWidget(data, index);
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "Vous n'avez éffectué aucune transaction",
                    style: TextStyle(color: recovaColor),
                  ),
                );
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: userGetOnwerObjectSave(),
      );
    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Mes données",
          style: TextStyle(color: Colors.white, fontSize: 30),),
        backgroundColor: recovaColor,
      ),
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40,),
            const Text("Mes données sur RECOVA",
              style: TextStyle(color: recovaColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold, ), textAlign: TextAlign.center,),
            const Divider(height: 40,),
            listUserObjectSave(),
            addObjectWidget(),
            const Divider(height: 20,),
            const SizedBox(height: 20,),
            // ownSettingOption("Enregistrer mes données sur RECOVA", Icons.add, FontWeight.normal, recovaColor, 18, (){
            //   var route = MaterialPageRoute(
            //     builder: (BuildContext context) => SaveMyDataFormPage(
            //       key: UniqueKey(), refreshState: refreshState,
            //     ),
            //   );
            //   Navigator.of(context).push(route);
            // }),
            const SizedBox(height: 30,),
            ],
        ),
      ),
    );
  }
}
