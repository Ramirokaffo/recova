import 'package:flutter/material.dart';
import 'package:projet_flutter2/xampple%20folder/StaggeredGridViews.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Opacityer());
  }
}

class Opacityer extends StatefulWidget {
  @override
  _OpacityerState createState() => _OpacityerState();
}

class _OpacityerState extends State<Opacityer> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";
  bool alertFire = true;

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
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Opacity(
                opacity: alertFire ? 1.0 : 0.8,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            list_image_asset[7],
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        height: 250,
                      ),
                      Container(
                        child: AnimatedOpacity(
                          opacity: alertFire ? 1.0 : 0.0,
                          duration: const Duration(seconds: 2),
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(list_image_asset[5]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Opacity(
                  opacity: alertFire ? 1.0 : 0.5,
                  child: const Text(
                    "Global Alert",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    alertFire = !alertFire;
                  });
                },

                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder(),),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),

                ),
                child: const Opacity(
                    opacity: 0.8,
                child: Text("GO TO >>", style: TextStyle(color: Colors.blue,
                fontWeight: FontWeight.bold, fontSize: 50),),),

              ),

            )
          ],
        )
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //     ],
      //   ),
      // ),
    );
  }
}
