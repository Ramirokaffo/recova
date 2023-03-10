import 'package:flutter/material.dart';
Widget buttonInfo(String text, Function onTap){
  return Material(
    borderRadius: BorderRadius.circular(25),
    color: const Color(0xFF20c5fe).withOpacity(0.5),
    elevation: 4.0,
    shadowColor: Colors.lightBlueAccent,
    child: InkWell(
      onTap: (){
        onTap();
      },
      splashColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.black,
          fontSize: 15.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.justify,),
        ),
      ),
    ),
  );
}