import 'package:flutter/material.dart';



Widget transition(AnimationController controller, String txt){
  return SlideTransition(
      position: Tween<Offset>(
          begin: Offset(0.0, -0.9), end: Offset.zero).animate(controller),
  child: Text(txt, style: TextStyle(color: Colors.white.withOpacity(0.8),
  fontSize: 30), textAlign: TextAlign.center,),);

}