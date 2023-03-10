import 'package:flutter/material.dart';
import 'package:projet_flutter2/OneObjectDataShowPage.dart';
import 'ConstantFile.dart';

class InitialSearchPage extends StatelessWidget {
  final List<dynamic> data;

  const InitialSearchPage({required Key key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget headWidget() {
      return Column(
        children: const [
          SizedBox(height: 10,),
          Text(
              "Voici ci-dessous les résultats de la recherche instantanée; "
              "verifiez si l'un de ces résultats correspond aux données que vous avez entré",
          style: TextStyle(color: recovaColor, fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.justify,),
          Divider(height: 20, color: recovaColor,)
        ],
      );
    }

    Widget oneResultWidget(List<dynamic> data, int index) {
      return ListTile(
        title: Text(objectIdToName[data[index]["objectType"]]!,
          style: const TextStyle(color: recovaColor, fontWeight: FontWeight.bold, fontSize: 20),),
        trailing: const Icon(Icons.arrow_forward_ios_outlined, color: recovaColor,),
        subtitle: Text(data[index]["objectName"], style: const TextStyle(color: recovaColor),),
        onTap: () {
          var route = MaterialPageRoute(
            builder: (BuildContext context) => SecondePage(
              key: UniqueKey(),
              recover_object_id: index,
              ojectList: data,
            ),
          );
          Navigator.of(context).push(route);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: recovaColor,
        title: const Text(
          "Recherche préliminaire",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
            itemCount: data.isNotEmpty ? data.length : 0,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [headWidget(), oneResultWidget(data, index)],
                );
              }
              return oneResultWidget(data, index);
            }),
      ),
    );
  }
}
