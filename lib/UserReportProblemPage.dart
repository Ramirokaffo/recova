import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:projet_flutter2/RecovaLoginPage.dart';


class UserReportProblemPage extends StatelessWidget {
  const UserReportProblemPage({required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Signaler un problème",
          style: TextStyle(color: Colors.white, fontSize: 25),),
        backgroundColor: recovaColor,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  <Widget>[
              const SizedBox(height: 120,),
              const Center(
                child: Text("Saisissez votre message",
                  style: TextStyle(color: recovaColor, fontSize: 25, fontWeight: FontWeight.bold),),
              ),
             const SizedBox(height: 20,),
              TextField(
                style: const TextStyle(color: recovaColor),

                maxLines: 5,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(borderSide: BorderSide(color: recovaColor, width: 20)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: recovaColor, width: 2, ), borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue, width: 2, ), borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.mail, color: recovaColor,),
                  iconColor: recovaColor,
                  labelText: "Message",
                  labelStyle: const TextStyle(color: recovaColor, fontSize: 25),
                ),
              ),
              const SizedBox(height: 50,),
              buttonInfo("Envoyer", (){}, context)
            ],
          ),
        ),
      ),
    );
  }
}
Widget buttonInfo(String text, Function onTap, BuildContext context) {
  return Material(
    borderRadius: BorderRadius.circular(25),
    color: recovaColor,
    elevation: 4.0,
    shadowColor: Colors.white,

    child: InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    ),
  );
}
