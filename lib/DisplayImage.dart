import 'package:flutter/material.dart';
import 'package:projet_flutter2/ConstantFile.dart';
import 'package:animator/animator.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:projet_flutter2/httpsRequestsFile.dart';
import 'dart:io';


class DisplaysImage extends StatefulWidget {
  final String image;
  final bool? islocal;

  const DisplaysImage(
      {required Key key, required this.image, bool this.islocal = false})
      : super(key: key);

  @override
  _DisplaysImage createState() => _DisplaysImage();
}

class _DisplaysImage extends State<DisplaysImage> with SingleTickerProviderStateMixin {
  bool onlyImgIsVisible = true;
  Offset offset = Offset.zero;
  final transController = TransformationController();
  late TapDownDetails doubleTaDetails;


  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;


  @override
void initState(){
  super.initState();
  print(widget.image);
  print(widget.image.split("image_picker").toList()[0].split("/").toList().last);
controller = TransformationController();
animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200),)
      ..addListener(() => controller.value = animation!.value);
  }


  @override
void dispose() {
  super.dispose();
  // controller.dispose();
  // animationController.dispose();
}




  handleDoubleTapDown(TapDownDetails details) {
    doubleTaDetails = details;
  }

  handleDoubleTap() {
    if (transController.value != Matrix4.identity()) {
      transController.value = Matrix4.identity();
    } else {
      final position = doubleTaDetails.localPosition;
      transController.value = Matrix4.identity()
        ..translate(-position.dx, -position.dy)
        ..scale(2.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final imageProvider = Image.network("https://picsum.photos/id/1001/5616/3744").image;

    void showMessage(String message, BuildContext context) {
      showMenu(
          context: context,
          position: const RelativeRect.fromLTRB(100, 200, 200, 300),
          items: <PopupMenuEntry>[
            PopupMenuItem(child: Text(message)),
            PopupMenuDivider(
              height: 200,
            )
          ]);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Visibility(
              // maintainSize: true,
              // maintainState: true,
              // maintainAnimation: true,
              // maintainInteractivity: true,
              // maintainSemantics: true,
              visible: onlyImgIsVisible,
              child: const Text(
                "Image",
                style: TextStyle(color: Colors.white),
              )),
          backgroundColor: Colors.black,
          leading: Visibility(
              visible: onlyImgIsVisible,
              child: IconButton(
                  onPressed: () {
                    // showMessage("oui tu as appuyé", context);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
          actions: [
            Visibility(
              visible: onlyImgIsVisible,
              child: IconButton(
                  onPressed: () async {
                    // showImageViewer(context, imageProvider, onViewerDismissed: () {
                    //   print("dismissed");
                    // });
                    //
                    if (widget.islocal == false) {
                      bool imageIsDownload =
                          await imageDownloadViaLink(widget.image);
                      if (imageIsDownload) {
                        showSimpleSnackbar(
                            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                            message: "L'image a été telechargée avec succès ",
                            context: context);
                      } else {
                        showSimpleSnackbar(
                            rootScaffoldMessengerKey: rootScaffoldMessengerKey,
                            message:
                                "Une erreur est suvenue lors du téléchargement de l'image",
                            context: context);
                      }
                    } else {}
                  },
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: GestureDetector(
        onTap: () {
          setState(() {
            onlyImgIsVisible = !onlyImgIsVisible;
          });
        },
        onDoubleTap: handleDoubleTap,
        onDoubleTapDown: ((details) {
          print("double tap down");
          handleDoubleTapDown(details);
        }),
        // onVerticalDragDown: (details) {
        //   // handleDoubleTapDown(details);
        //
        // },
        onPanUpdate: (details) {
          setState(() {
            offset = Offset(offset.dx + details.delta.dx,
                offset.dy + details.delta.dy);
          });
          print(details);
        },
        child: InteractiveViewer(
          // onInteractionEnd: ((details) {
          //   // print("object");
          //   resetAnimation();
          // }),
          clipBehavior: Clip.none,
          transformationController: controller,
          // maxScale: 4,
          // minScale: 1,
          // panEnabled: false,
          child: widget.islocal == true
              ? Image.file(
            File(widget.image),
                  width: double.infinity,
                  height: double.infinity,
            fit: BoxFit.contain,

          )
              : Hero(
                tag: int.tryParse(widget.image.split("image_picker").toList()[0].split("/").toList().last)?? widget.image.split("image_picker").toList()[0].split("/").toList().last,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                    placeholder: placeholder, image: widget.image,
                  imageErrorBuilder: (context, object, stackTrace) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.white,
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                              child: Text(
                                "Erreur lors du chargement de l'image...",
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      ),
                    );
                  },),
              ),
        ),
        ),
      ),
    );
  }

  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity()
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticIn)
    );
    animationController.forward(from: 0);
  }

}
