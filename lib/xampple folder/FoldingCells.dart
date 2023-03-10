import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
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
        home: FoldingCells()
    );
  }
}

class FoldingCells extends StatefulWidget {
  @override
  _FoldingCellsState createState() => _FoldingCellsState();
}

class _FoldingCellsState extends State<FoldingCells> {
  var info = "Bienvenue sur l'application de ramiro";
  var welcome = "Bienvenue sur mon application";

  List<GlobalKey<SimpleFoldingCellState>> listFoldingCellKey = List<GlobalKey<SimpleFoldingCellState>>.generate(25, (index) => GlobalKey<SimpleFoldingCellState>());


  var item = List<String>.generate(25, (index) => "Article : $index");

  final folding_cellkey = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey1 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey2 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey3 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey4 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey5 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey6 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey7 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey8 = GlobalKey<SimpleFoldingCellState>();
  final folding_cellkey9 = GlobalKey<SimpleFoldingCellState>();

  Widget _buildFrontWidget(GlobalKey<SimpleFoldingCellState> folding_cellkey) {
    return Container(
      color: const Color(0xFFffcd3c),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          const Align(
            alignment: Alignment.center,
            child: Text(
              "CARD TITLE",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => folding_cellkey.currentState?.toggleFold(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(80, 40),
              ),
              child: const Text(
                "OPEN",
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerWidget(GlobalKey<SimpleFoldingCellState> folding_cellkey) {
    return Container(
      color: const Color(0xFFecf2f9),
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              "CARD TITLE",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "CARD DETAIL",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => folding_cellkey.currentState?.toggleFold(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(80, 40),
              ),
              child: const Text(
                "Close",
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Widget hautWidget(String image, GlobalKey<SimpleFoldingCellState> foldingCell){
  //   return Container(
  //     child: Container(
  //       child: Wrap(
  //         children: <Widget>[
  //           Image(image: AssetImage(image)),
  //           TextButton(onPressed: (){
  //             foldingCell.currentState?.toggleFold();
  //
  //           },
  //               child: Text("Cliquez pour fermer", style: TextStyle(color: Colors.indigo),))
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget principalWidget(String menu, IconData iconMenu, String image,
  //   GlobalKey<SimpleFoldingCellState> foldingCell) {
  //   return Container(
  //     color: Colors.blue,
  //     alignment: Alignment.center,
  //     child: Row(
  //       children: <Widget>[
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: Colors.purple,
  //           ),
  //           child: Container(
  //             child: Row(
  //               children: <Widget>[
  //                 Container(
  //                   child: Padding(
  //                     padding: EdgeInsets.only(left: 70, top: 70),
  //                     child: Column(
  //                       children: <Widget>[
  //                         Text(menu,
  //                           style: const TextStyle(
  //                               fontSize: 20, fontWeight: FontWeight
  //                               .bold, color: Colors.red),),
  //                         Icon(iconMenu, size: 50, color: Colors.orange,)
  //                       ],
  //                     ),),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: TextButton(
  //               onPressed: (){
  //                 foldingCell.currentState?.toggleFold();
  //
  //               },
  //
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20),
  //                   image: DecorationImage(
  //                       image: AssetImage(image))
  //
  //                 ),
  //               )),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
      body: Container(
        color: Colors.white10,
        child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
        const Padding(
        padding: EdgeInsets.only(left: 100, bottom: 15),
        child: Text("Resto de la ville", style: TextStyle(
            color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      Container(
          child: SimpleFoldingCell.create(
            key: listFoldingCellKey[0],
            frontWidget: _buildFrontWidget(listFoldingCellKey[0]),
            innerWidget: _buildInnerWidget(listFoldingCellKey[0]),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey1,

            frontWidget: _buildFrontWidget(folding_cellkey1),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey1),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey2,

            frontWidget: _buildFrontWidget(folding_cellkey2),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey2),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey4,

            frontWidget: _buildFrontWidget(folding_cellkey4),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey4),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey5,

            frontWidget: _buildFrontWidget(folding_cellkey5),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey5),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey6,

            frontWidget: _buildFrontWidget(folding_cellkey6),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey6),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey7,

            frontWidget: _buildFrontWidget(folding_cellkey7),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey7),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey8,

            frontWidget: _buildFrontWidget(folding_cellkey8),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey8),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
      Container(
          child: SimpleFoldingCell.create(
            key: folding_cellkey9,

            frontWidget: _buildFrontWidget(folding_cellkey9),
            // principalWidget(
            //     "Salade",
            //     Icons.restaurant,
            //     list_image_asset[5],
            //     folding_cellkey),
            innerWidget: _buildInnerWidget(folding_cellkey9),
            // hautWidget(list_image_asset[4], folding_cellkey),
            cellSize: Size(MediaQuery
                .of(context)
                .size
                .width, 200),
          ),

      ),
    ]

    ),
    ),
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


class FoldingCellSimpleDemo extends StatelessWidget {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2e282a),
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(),
        innerWidget: _buildInnerWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, 140),
        padding: EdgeInsets.all(15),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 10,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
      color: Color(0xFFffcd3c),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "CARD TITLE",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              child: Text(
                "OPEN",
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(80, 40),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerWidget() {
    return Container(
      color: Color(0xFFecf2f9),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "CARD TITLE",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "CARD DETAIL",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              child: Text(
                "Close",
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(80, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}