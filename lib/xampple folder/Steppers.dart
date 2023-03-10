import 'package:flutter/material.dart';

var directory = "/Users/user/StudioProjects/projet_flutter2/images/";
List list_image_asset = [
  "${directory}4E07182D-4A69-4C8E-8D3C-7CB8E2D94807_1_105_c.jpeg",
  "${directory}6DB61D38-459B-4513-B789-E91007C38D43_1_105_c.jpeg",
  "${directory}6DCFCEA4-C9DB-4430-9782-CF42AD679964_1_105_c.jpeg",
  "${directory}9FE8E63A-D0D9-4C2F-8001-5FFA7BD9992A_1_105_c.jpeg",
  "${directory}21A981B7-7975-4D63-8560-D0EE7C44E904_1_105_c.jpeg",
  "${directory}520ABE5E-E405-4776-A81A-FAB4989BEB7C_1_105_c.jpeg",
  "${directory}950DBFBF-50B4-49B7-995D-D808C0333820_1_105_c.jpeg",
  "${directory}73597295-4FA3-4F96-81AF-C345DCDF82C4_1_105_c.jpeg",
  "${directory}A2198AA0-CCA8-4F5F-8CBF-B6A7960FF260_1_105_c.jpeg",
  "${directory}CE21FDB5-B18C-42E4-A104-A092BC1D9E59_1_105_c.jpeg",
  "${directory}ED9B8C43-D385-426C-8712-3DE75ED0E0EA_1_105_c.jpeg",
  "${directory}FADEE814-2567-4954-9ADE-5736DBEF06FD_1_105_c.jpeg"
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StepperSample());
  }
}

class StepperSample extends StatefulWidget {
  @override
  _StepperSampleState createState() => _StepperSampleState();
}

class _StepperSampleState extends State<StepperSample> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";

  int initial_steppe = 0;

  List<Step> steps = [
    const Step(
      title: Text(
        "Confirmer votre nom et prenom",
        style: TextStyle(color: Colors.blue),
      ),
      content: Text("Ramiro kaffo"),
      isActive: true,
      subtitle: Text("Etape 1"),
    ),
    const Step(
      title: Text(
        "Confirmer votre adresse",
        style: TextStyle(color: Colors.orange),
      ),
      content: Text("ramirokaffo.com"),
      isActive: true,
      subtitle: Text("Etape 2"),
    ),
    const Step(
      title: Text(
        "Confirmer votre numero de telephone",
        style: TextStyle(color: Colors.purple),
      ),
      content: Text("672279946"),
      isActive: true,
      subtitle: Text("Etape 3"),
    ),
    const Step(
      title: Text(
        "Donnez votre sexe",
        style: TextStyle(color: Colors.red),
      ),
      content: Text("Masculin"),
      isActive: true,
      subtitle: Text("Etape 4"),
    ),
    Step(
        title: const Text(
          "Merci",
          style: TextStyle(color: Colors.green),
        ),
        content: Image.asset(list_image_asset[7]),
        isActive: true,
        subtitle: const Text("FIN"),
        state: StepState.complete),
  ];

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
        body: Stepper(

          steps: steps,
          onStepTapped: (step) {
            initial_steppe = step;
          },
          type: StepperType.vertical,
          onStepContinue: () {
            setState(() {

              debugPrint("$initial_steppe");
              if (initial_steppe < steps.length - 1) {
                initial_steppe = initial_steppe + 1;
              } else {
                initial_steppe = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (initial_steppe > 0) {
                initial_steppe = initial_steppe - 1;
              } else {
                initial_steppe = 0;
              }
            });
          },
          currentStep: this.initial_steppe,
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
