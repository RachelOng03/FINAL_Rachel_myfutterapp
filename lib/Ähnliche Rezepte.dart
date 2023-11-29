
//Importieren der relevanten Dart-Files
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
import 'package:myfutterapp/Uebersichtsseite.dart';
import 'package:myfutterapp/zutatDatabaseEditHive.dart';
import 'package:myfutterapp/databaseBoxAehnlich.dart';
import 'package:myfutterapp/header.dart';


class aenlicheRezepte extends StatefulWidget {
  aenlicheRezepte();
  @override
  _aenlicheRezepte createState() => _aenlicheRezepte ();}

class _aenlicheRezepte extends State<aenlicheRezepte>{

  //Der Wert aus dem Textfeld wird später die Zutat
  TextEditingController zutatController = TextEditingController();

  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: yellowToneLight,

      appBar:  AppBar(

        //Automatischen Pfeil entfernen
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        elevation: 0.0,
        backgroundColor: yellowText,

        //Header (ausgelagert)
        title: header(title: ' MyFutterApp '),
      ),

      // Scrollbarer Teil mit Auflistung der Rezepte.
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              SizedBox(height: 20.00,),

              Text('Ähnliche Rezepte:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

              SizedBox(height: 10.00,),

              Container(

                //Stylen
                height: 500.00,
                width: 370.00,
                decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                // Schauen, ob es passende Rezepte gibt. Wenn es mindestens ein Rezept gibt, erfolgt die Ausgabe-Schleife
                child: boxAehnlich.length != 0?
                ListView.builder (
                  //Schleife so oft durchlaufen, wie die Anzahl der Ergebnis-Rezepte
                  itemCount: boxAehnlich.length, itemBuilder: (context, index) {

                  //Zunächst alle benötigten Informationen aus der Datenbank zur Ausgabe holen.
                  databaseBoxAehnlich aehnlRezept = boxAehnlich.getAt(index);
                  int ID = aehnlRezept.aehnlich_id;
                  databaseBoxRezepte rezepte = boxRezepte.getAt(ID);
                  String zeit = rezepte.rezepte_zeit;
                  String titel = rezepte.rezepte_titel;
                  int rezept = rezepte.rezepte_id;

                  if (boxAehnlich.length != 0) {
                    return ListTile(

                      //Weiterleiten beim Anklicken zum Detailview.
                      title: GestureDetector(onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Detailview(index: ID),),);
                      },

                        child: Align(
                          alignment: Alignment.bottomCenter,
                          // Übersichtsbox erstellen
                          child: Container(
                            height: 70.00,
                            width: 370.00,

                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),

                            //Inhalt pro Rezeptübersicht (Titel, Zubereitungszeit)
                            child: Row(

                              children: [

                                SizedBox(width: 40.00,),

                                // Rezeptnummerierung erfolgt automatisch zur Übersichtlichkeit
                                // (immer ab 1 aufwärts Zählend für alle Items die ausgegeben werden)

                                Text((index+1).toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'CooperBlack',),),

                                SizedBox(width: 40.00,),

                                // Rezeptübersicht Inhalt
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.00,),
                                    // Inhalt einer jeweiligen Rezeptübersicht
                                    Text("$titel", style: TextStyle(color: darkGrey, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rooney',),),

                                    Text("Zubereitungszeit: $zeit", style: TextStyle(color: yellowText, fontSize: 10.0, fontFamily: 'Rooney',),),
                                    ],
                                  ),
                              ],
                              // Schließen einer Rezeptübersicht
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                )

                // Falls es keine passenden Ergebnisse gibt
                : Column(

                  children: [

                    SizedBox(height: 170.00,),

                    Container (
                      height: 50.00,
                      width: 350.00,

                      child: Align (
                        alignment: Alignment.center,
                        child: Text("Leider keine passenden", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0, fontFamily: 'CooperBlack',),),
                      ),
                    ),

                    Container (
                      height: 50.00,
                      width: 350.00,

                      child: Align (
                        alignment: Alignment.center,
                        child: Text("Rezepte!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0, fontFamily: 'CooperBlack',),),
                      ),
                    ),


                    Container (
                      height: 50.00,
                      width: 350.00,

                      child: Align (
                        alignment: Alignment.center,
                        child: Text("Bitte versuche es mit anderen Zutaten!", style: TextStyle(color: yellowText, fontWeight: FontWeight.bold, fontSize: 15.0, fontFamily: 'Rooney',),),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5.00,),

              // Zurück zur Ausgabe Knopf
              GestureDetector (onTap: () { Navigator.of(context).push (MaterialPageRoute(builder: (context) => ausgabe()),);},
                child: Container(

                  //Gestaltung
                  height: 40.00, width: 350.00,
                  decoration: BoxDecoration (color: yellowText, borderRadius: BorderRadius.circular(20)),

                  child:
                  Center(
                    child:
                    Text ("Zurück zu den ursprünglichen Ergebnissen", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),),
                ),),

            ],
          ),
        ),
      ),
      // Footer (ausgelagert)
      bottomNavigationBar: Footer(),
    );
  }
}