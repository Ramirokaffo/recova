import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/main.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';

class RecoverTarifPage extends StatefulWidget {
  const RecoverTarifPage({required Key key})
      : super(key: key);
  _RecoverTarifPage createState() => _RecoverTarifPage();
}


class _RecoverTarifPage extends State<RecoverTarifPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Plan tarifaire",
          style: TextStyle(color: Colors.white, fontSize: 30),),
        backgroundColor: recovaColor,
      ),

      body:SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            builder: (ctx, snapshots) {
              if (snapshots.connectionState == ConnectionState.done) {
                if (snapshots.hasError) {
                  return Column(
                    children: [
                      const SizedBox(height: 150,),
                      Center(
                        child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/3f97aedfa1f1e898d7d0b3ac139e18e7.jpg",
                            context: context),
                      ),
                    ],
                  );
                } else if (snapshots.hasData) {
                  final datas = snapshots.data as List;
                  if (datas.isNotEmpty) {
                    return TarifTable(data: datas);
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 150,),
                        Center(
                          child: errorPageWidget(onTap: (){setState(() {});}, assetImage: "images/8516dec954b578b3b15def9f672e9930.jpg",
                              context: context, message: "Aucune donnée disponible", buttonIsVisible: false),
                        ),
                      ],
                    );
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            future: getAllObjectType(precision: "oui"),
          ),
        ),
      ),
    );
  }
}


class TarifTable extends StatelessWidget {
  List<dynamic> data;

  TarifTable({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
      child: Column(
        children: [
          DataTable(
            border: const TableBorder(
              bottom: BorderSide(color: recovaColor),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            ) ,
            showBottomBorder: false,
              dataRowHeight: 60,
              columns: const [
                DataColumn(label: Text("Categorie", style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold, fontSize: 20),)),
                DataColumn(label: Text("Retrouvé", style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold, fontSize: 20),)),
                DataColumn(label: Text("Perdu", style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold, fontSize: 20),))
              ],
              rows: data.map((objectType)=>DataRow(
                color: MaterialStateProperty.all(Colors.white10),
                  cells: [DataCell(Text(objectType["type"],style: const TextStyle(color: recovaColor, fontSize: 15, fontWeight: FontWeight.bold),),),
                    DataCell(Text(objectType["recoverPrice"].toString(),style: const TextStyle(color: recovaMixColor, fontSize: 15)), placeholder: true),
                    DataCell(Text(objectType["losePrice"].toString(),style: const TextStyle(color: recovaMixColor, fontSize: 15))),
                  ]
              )
              ).toList()
          ),
          const SizedBox(height: 40,),
          const Text("Pour plus d'information sur la façon dont les prix ont été fixés, "
              "reférez-vous au guide d'utilisation", style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
