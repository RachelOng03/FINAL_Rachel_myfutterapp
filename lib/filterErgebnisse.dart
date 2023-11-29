
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/filterWidget.dart';
import 'package:myfutterapp/zutatDatabaseEditHive.dart';
import 'package:myfutterapp/boxes.dart';
import 'package:myfutterapp/zutat.dart';
import 'package:myfutterapp/footer.dart';
import 'package:myfutterapp/databaseBoxMapping.dart';
import 'package:myfutterapp/databaseBoxRezepteGefiltert.dart';
import 'package:myfutterapp/databaseBoxRezepte.dart';
import 'package:myfutterapp/databaseBoxFilter.dart';
import 'package:myfutterapp/filterErgebnisse.dart';
import 'package:myfutterapp/Uebersichtsseite.dart';

class filterErgebnisse extends StatefulWidget {
  filterErgebnisse();
  @override
  _filterErgebnisse createState() => _filterErgebnisse();}


class _filterErgebnisse extends State<filterErgebnisse> {

  // Hier werden die Ergebnisse für den Filter erstellt
  void _ergebnisseRezepte () async {

    // Box wird geleert
    await boxGefilterteRezepte.clear();

    // Die Ausgabe der gefilterten & ähnlichen Rezepte läuft über die Position, nicht über die ID wie die Suche.
    // Die Boxen "boxgefilterteRezepte" und "boxaehnlicheRezepte" enthalten die Positionen der Rezepte in der Rezeptbox

    //Alle Rezepte werden durchgegangen
    for (var i = 0; i < boxRezepte.length; i++) {
      List<int> items = [];
      int counter = 0;
      int mapping_rezept = 1200000;

      databaseBoxRezepte rezept = boxRezepte.getAt(i);
      int rezept_id = rezept.rezepte_id;

      //Alle Zutaten im Filter werden durchgegangen
      for (var j = 0; j < boxFilter.length; j++) {
        databaseBoxFilter filter = boxFilter.getAt(j);
        int filter_id = filter.boxFilter_id;

        // Für jede Kombination wird geschaut, ob diese als Mapping vorliegt
        for (var k = 0; k < boxMapping.length; k++) {
          databaseBoxMapping mapping = boxMapping.getAt(k);
          int mapping_rezept = mapping.mappingRezept_id;
          int mapping_zutat = mapping.mappingZutat_id;

          // Wenn es die Kombination gibt wird diese in der Liste "items" gespeichert
          if (mapping_rezept == rezept_id && mapping_zutat == filter_id) {
            items.add(mapping_rezept);
            print(items);
          }
        }
      }

      // Für jedes Rezept wird geschaut, wieviele Zutaten dieses insgesamt hat
      // Hierfür werden die Einträge in Mapping gezählt.

      for (var k = 0; k < boxMapping.length; k++) {
        databaseBoxMapping mapping = boxMapping.getAt(k);
        int mapping_rezept = mapping.mappingRezept_id;
        if (mapping_rezept == rezept_id) {
          counter = counter + 1;
        }
      }

      // Stimmt die Anzahl der Zuordnungen durch den Filter mit der Gesamtanzahl an Zutaten überein,
      // dann wird das Rezept in die Box der gefilterten Rezepte als Ergebnis mit aufgenommen

      if (counter == items.length) {
        setState(() {
          boxGefilterteRezepte.put('key_${boxGefilterteRezepte.length}', databaseBoxRezepteGefiltert(gefilterteRezepte_id: i),);
        });
      }
    }

    // Nach Abschluss der Filterung wird auf die Übersichtsseite weitergeleitet
    Navigator.of(context).push (MaterialPageRoute(builder: (context) => ausgabe()),);
}

    @override
    Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Padding(
          padding: EdgeInsets.all(20.00),
          child: Wrap(
          //Boxen mit Abstand anordnen
          spacing: 15.00,
          runSpacing: 5.00,
          //Zentrieren
          alignment: WrapAlignment.center,

          // Die aktuelle Anzahl der Zutaten definiert die Anzahl der erstellten Filterchips
          children: List.generate (boxZutat.length, (index) => Container(

          //Für das Erstellen der Filterchips gibt es eine eigene Dart Datei, in die Nummer der aktuellen Zutat übergeben wird
          child: filterWidget(index: index),
          ),
          ),
          ),
          ),


        SizedBox(height: 10.00,),

        // Der Rezeptsuche-Starten-Knopf
           GestureDetector (onTap: () {

             // Bei Anklicken: Die Rezepte werden gefiltert
             _ergebnisseRezepte();},

             //Zur Übersichtsseite weiterleiten:
              child: Container(

              //Gestaltung
              height: 40.00, width: 350.00,
              decoration: BoxDecoration (color: yellowText, borderRadius: BorderRadius.circular(20)),
              child:
                 Center(
                   child:
                  Text ("Rezeptsuche starten", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),
                ),
             ),
            ),
            SizedBox(height: 20.00,),
        ],
      ),
    );
  }
}
