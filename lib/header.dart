
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/rezeptcreate.dart';


class header extends StatefulWidget {
  final String title;
  header({required this.title});
  @override
  _header createState() => _header();
}

class _header extends State<header>{

  @override
  Widget build(BuildContext context){
      return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                  'assets/images/Knoblauch.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded (
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CooperBlack',
                      color: Colors.black,
                      ),
                    ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                  'assets/images/Zwiebel.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
      );

  }
}