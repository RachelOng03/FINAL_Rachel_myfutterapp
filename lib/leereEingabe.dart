
import 'package:flutter/material.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/zutat.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfutterapp/boxes.dart';
import 'package:myfutterapp/databaseBoxFilter.dart';
import 'package:myfutterapp/databaseBoxRezepte.dart';
import 'package:myfutterapp/databaseBoxMapping.dart';
import 'package:myfutterapp/databaseBoxRezepteGefiltert.dart';
import 'package:myfutterapp/footer.dart';
import 'package:myfutterapp/detailview.dart';
import 'package:myfutterapp/Ähnliche Rezepte.dart';
import 'package:myfutterapp/zutatDatabaseEditHive.dart';
import 'package:myfutterapp/databaseBoxAehnlich.dart';
import 'package:myfutterapp/header.dart';

class leereEingabe extends StatefulWidget {
  leereEingabe();
  @override
  _leereEingabe createState() => _leereEingabe();}

// Die leere Eingabe Seite ist nur eine grafische Ausgabe, falls keine Daten bei Rezepte Teilen eingegeben werden.
class _leereEingabe extends State<leereEingabe> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowToneLight,

      // Header (ausgelagert)
      appBar: AppBar(

        //Automatischen Pfeil entfernen
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        elevation: 0.0,
        backgroundColor: yellowText,

        title: header(title: ' MyFutterApp '),
      ),

      // Ausgabe Text der darauf verweist, dass die Eingabe leer war
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              SizedBox(height: 15.00,),

              Text('UPS?!', style: TextStyle(color: darkGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'Rooney',),),

              SizedBox(height: 10.00,),

              Container(

                //Stylen
                height: 500.00,
                width: 370.00,
                decoration: BoxDecoration(color: yellowToneDark,
                    borderRadius: BorderRadius.circular(20)),

                child: Column(
                  children: [

                    SizedBox(height: 170.00,),

                    Container(
                      height: 50.00,
                      width: 350.00,

                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Du hast leider nicht", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: 'CooperBlack',),),
                      ),
                    ),

                    Container(
                      height: 50.00,
                      width: 350.00,

                      child: Align(
                        alignment: Alignment.center,
                        child: Text("alle Felder ausgefüllt!", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          fontFamily: 'CooperBlack',),),
                      ),
                    ),


                    Container(
                      height: 50.00,
                      width: 350.00,

                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Bitte versuche es bitte noch einmal.",
                          style: TextStyle(color: yellowText,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'Rooney',),),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 10.00,),

            ],
          ),
        ),
      ),
      // Footer (ausgelagert)
      bottomNavigationBar: Footer(),
    );
  }
}