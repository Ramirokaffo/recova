// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:projet_flutter2/CircleAvatar.dart';
import 'package:projet_flutter2/main.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_flutter2/ConstantFile.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: soir()
    );
  }
}
class soir extends StatefulWidget {
  @override
  _soirState createState() => _soirState();
}

class _soirState extends State<soir> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  String value = "";
  final TextEditingController txt = TextEditingController();
  List <String> msg = [];
  Widget msgUser(BuildContext context, String message){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 60, right: 15),
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              backgroundImage: AssetImage("images/hotel_4.png"),
              radius: 30,
            ),
            title: Container(
              child: Text(message,
                style: TextStyle(fontSize: 15, color: Colors.black),),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // info = "Bienvenue sur le tuto";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                      topLeft: Radius.circular(70),
                    )
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 175),
                        child: Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/hotel_4.png"),
                            radius: 35,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Text("Nadia", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
            ),
             Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 50,),
                      Container(
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/hotel_4.png"),
                          radius: 35,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Beaurel", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),

                    ],
                  ),
                ),),
             Expanded(
              flex: 8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: msg.length,
                  itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: <Widget>[
                      Container(
                        child: msgUser(context, msg[index].toString()),
                      )
                    ],
                  );
                  }),),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: ()async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                  // final XFile? image = (await _picker.pickMultiImage()) as XFile?;
                  print("voici l'image: ${image?.path}");
                  print("voici l'image: ${image?.name}");
                  },
                          icon: Icon(Icons.photo_camera),
                      ),
                      Icon(Icons.mic),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextField(
                            controller: txt,
                            keyboardType: TextInputType.text,
                            enabled: true,
                            autofocus: false,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              icon: Icon(Icons.keyboard, color: Colors.black,),
                              hintText: "Tapez votre texte ici",
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              value = txt.text;
                              msg.add(value);
                              txt.clear();
                            });
                          },
                          icon: Icon(Icons.send)),
                      IconButton(
                          onPressed: () async {
                            final ImagePicker _picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          print(image);
                            },

                          icon: Icon(Icons.image)),
                    ],
                  ),
                  ),

                ),),

          ],
        ),
      )

    );
  }
}
