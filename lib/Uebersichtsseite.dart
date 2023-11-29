
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
import 'package:myfutterapp/Ähnliche Rezepte.dart';
import 'package:myfutterapp/zutatDatabaseEditHive.dart';
import 'package:myfutterapp/databaseBoxAehnlich.dart';
import 'package:myfutterapp/header.dart';

class ausgabe extends StatefulWidget {
  ausgabe();
  @override
  _ausgabe createState() => _ausgabe();}

class _ausgabe extends State<ausgabe>{

  //Hier der Filter für ähnliche Rezepte (alle die mind. eine Zutat der gewünschten Zutaten enhalten)
  void _aehnlicheRezepte () async {

    // Ähnlich-Box leeren
    await boxAehnlich.clear();

    List<int> items = [];
    List<int> no_duplicates = [];
    bool duplicate = false;

    // Die Ausgabe der gefilterten & ähnlichen Rezepte läuft über die Position, nicht über die ID wie die Suche.
    // Die Boxen "boxgefilterteRezepte" und "boxaehnlicheRezepte" enthalten die Positionen der Rezepte in der Rezeptbox.

    //Alle existierenen Rezepte werden durchgegangen
    for (var i = 0; i < boxRezepte.length; i++) {

      late int mapping_rezept;

      //Das aktulle Rezept und die daraus benötigste ID werden aus der Datenbank geholt
      databaseBoxRezepte rezept = boxRezepte.getAt(i);
      int rezept_id = rezept.rezepte_id;

      //Alle existierenen Zutaten, die aktuell im Filter liegen, werden durchgegangen
      for (var j = 0; j < boxFilter.length; j++) {

        //Die aktulle Zutat im Filter und die daraus benötigste ID werden aus der Datenbank geholt
        databaseBoxFilter filter = boxFilter.getAt(j);
        int filter_id = filter.boxFilter_id;

        //Alle existierenen Mappings werden durchgegangen
        for (var k = 0; k < boxMapping.length; k++) {

          //Das aktuelle Mapping und beide IDs werden aus der Datenabnk geholt
          databaseBoxMapping mapping = boxMapping.getAt(k);
          int mapping_rezept = mapping.mappingRezept_id;
          int mapping_zutat = mapping.mappingZutat_id;

          //Wenn das aktuelle Rezept die Zutat enthält,
          //wird das Rezept in Items abgelegt
          if (mapping_rezept == rezept_id && mapping_zutat == filter_id) {
            items.add(i);
          }
        }
      }
    }

    // Wenn nur ein Item passt, kann dieses direkt in den Filter gepackt werden
    if (items.length == 1){
      setState(() {
        boxAehnlich.put('key_${boxAehnlich.length}', databaseBoxAehnlich(aehnlich_id: items[0]),);
      });
    }

    //Aus items werden bei mehr als einem Item noch die Duplikate entfernt, damit Rezepte nicht zwei Mal angezeigt werden.
    if (items.length > 1){
      no_duplicates.add(items[0]);
        for (var l = 1; l < items.length; l++) {
          duplicate = false;
          for (var m = 0; m < no_duplicates.length; m++) {
            if (items[l] == no_duplicates[m]) {
              duplicate = true;
              break;
            }
          }
          if (duplicate == false) {
            no_duplicates.add(items[l]);
            print(no_duplicates);
          }
        }

        // Die Liste ohne Duplikate wird in die Datenbankd gespeichert
    for (var n = 0; n < no_duplicates.length; n++) {
      setState(() {
        boxAehnlich.put('key_${boxAehnlich.length}', databaseBoxAehnlich(aehnlich_id: no_duplicates[n]),);
      });
    }
    }

    // Weiterleitung auf die Ähnliche-Rezepte-Seite
    Navigator.of(context).push (MaterialPageRoute(builder: (context) => aenlicheRezepte()),);

  }

  // Der Wert aus dem Textfeld wird später die Zutat
  TextEditingController zutatController = TextEditingController();


  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: yellowToneLight,

      appBar: AppBar(

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

                SizedBox(height: 15.00,),

                Text('Rezepte:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),

                Container(

                  //Stylen
                  height: 500.00,
                  width: 370.00,
                  decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                  // Schauen, ob es passende Rezepte gibt. Wenn es mindestens ein Rezept gibt, erfolgt die Ausgabe-Schleife
                  child: boxGefilterteRezepte.length != 0?
                      ListView.builder (

                          //Schleife so oft durchlaufen, wie die Anzahl der Ergebnis-Rezepte
                          itemCount: boxGefilterteRezepte.length, itemBuilder: (context, index){

                            //Zunächst alle benötigten Informationen aus der Datenbank zur Ausgabe holen.
                          databaseBoxRezepteGefiltert gefRezept = boxGefilterteRezepte.getAt(index);
                          int ID = gefRezept.gefilterteRezepte_id;
                          databaseBoxRezepte rezepte = boxRezepte.getAt(ID);
                          String zeit = rezepte.rezepte_zeit;
                          String titel = rezepte.rezepte_titel;
                          int rezept = rezepte.rezepte_id;


                          return ListTile(

                            title: GestureDetector (

                              //Weiterleiten beim Anklicken zum Detailview.
                              onTap: () { Navigator.of(context).push (MaterialPageRoute(builder: (context) => Detailview(index: ID),),);},

                              child: Align(
                                alignment: Alignment.bottomCenter,

                                // Übersichtsbox erstellen
                                child: Container (
                                  height: 70.00,
                                  width: 370.00,

                                  decoration: BoxDecoration (color: Colors.white, borderRadius: BorderRadius.circular(20)),

                                  //Inhalt pro Rezeptübersicht (Titel, Zubereitungszeit)
                                  child: Row(

                                    children: [

                                      SizedBox (width: 40.00,),

                                      // Rezeptnummerierung erfolgt automatisch zur Übersichtlichkeit
                                      // (immer ab 1 aufwärts Zählend für alle Items die ausgegeben werden)

                                      Text((index+1) .toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'CooperBlack',),),

                                      SizedBox (width: 40.00,),

                                      // Rezeptübersicht Inhalt
                                      Column (
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          SizedBox(height: 10.00,),

                                          // Inhalt einer jeweiligen Rezeptübersicht
                                          Text("$titel", style: TextStyle (color: darkGrey, fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rooney',),),

                                          Text ("Zubereitungszeit: $zeit", style: TextStyle (color: yellowText, fontSize: 10.0, fontFamily: 'Rooney',),),

                                        ],
                                      ),
                                    ],
                                    // Schließen einer Rezeptübersicht
                                  ),
                                ),
                              ),
                            ),
                            );
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


                SizedBox(height: 10.00,),

                // Zu den ähnlichen Ergebnissen Knopf
                GestureDetector (onTap: () {

                  // Funktion ähnlicheRezepte erstellt die FIlterung für ähnliche Ergebnisse,
                  // und wird beim anklicken aufgerufen.
                  _aehnlicheRezepte();},

                  // Optische Gestaltung des Buttons
                  child: Container(

                    height: 40.00, width: 350.00,
                    decoration: BoxDecoration (color: yellowText, borderRadius: BorderRadius.circular(20)),

                    child:
                    Center(
                      child:
                      Text ("Ähnliche Ergebnisse", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),),
                  ),
                ),
              ],
           ),
          ),
       ),

      //Footer (ausgelagert)
      bottomNavigationBar: Footer(),
    );
  }
}