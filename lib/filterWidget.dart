
//Relevante Dart-Files importieren
import 'package:flutter/material.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/zutat.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfutterapp/boxes.dart';
import 'package:myfutterapp/databaseBoxFilter.dart';


class filterWidget extends StatefulWidget {
  // Index initialisieren
  final int index;
  // Definieren, dass ein index für diese Funktion required ist
  filterWidget({required this.index});

  @override
  _filterWidget createState() => _filterWidget();
}

  class _filterWidget extends State<filterWidget> {

    //Variablen initieren
    //Alle mit "late", damit die Werte erst später zugewiesen werden können

    //Hier die Variablen für die Zutatenbox-Schleife
    late int nummerZutat;
    late Zutat aktuelleZutat;
    late int zutatid;

    //Hier die Variablen für die Filterbox-Schleife
    late int nummerZutatFilter;
    late databaseBoxFilter aktuelleZutatFilter;
    late int zutatidFilter;

    //Hier die Variable die speichert, ob aktuell etwas ausgewählt ist oder nicht
    late bool gefiltert;

    //Hier wird der Initialzustand festgelegt
    void initState() {
      super.initState();

      //TEIL I:
      //Zutatenbox durchgehen, um die Zutat die gebaut werden soll zu bestimmen

      //Die zutat_id ist der index + 1, da bei den zutat_ids mit 1 beim Erstellen angefangen wurde
      //Die aktuelle id wird in nummerZutat festgehalten
      nummerZutat = widget.index + 1;

      //Aktuelles Item wird hier aus der Zutatenbox geholt
      for (var i = 0; i < boxZutat.length; i++) {
        //Aktuelle Zutat zuweisen
        var zutat = boxZutat.getAt(i);
        // Abspeichern, falls die zutat_id passt
        if (nummerZutat == zutat.zutat_id) {
          aktuelleZutat = zutat;
          // Den Platz des Items in der ZutatenBox speichern
          zutatid = i;
          //Abbrechen der Schleife falls die Zutat gefunden wurde
          break;
        }
      }


      //TEIL II:
      //Schauen, welche Zutaten nach dem letzten Filtern noch im Filter liegen
      //(gefiltert initialisieren)

      //Nur laufen lassen, falls der Filter nicht leer ist
      if (boxFilter.length != 0) {
        for (var i = 0; i < boxFilter.length; i++) {
          //Aktuelle Zutat zuweisen
          var zutatgewaehlt = boxFilter.getAt(i);

          // Gefiltert auf wahr setzen, falls Zutat schon im Filter ist
          if (nummerZutat == zutatgewaehlt.boxFilter_id) {
            gefiltert = true;
            //Abbrechen der Schleife falls Zutat gefunden
            break;

          } else {
            //Falls nicht in der Box: gefiltert ist false
            gefiltert = false;

          }
        }
      } else {
        //Falls die Box leer ist, ist gefiltert automatisch false
        gefiltert = false;
      }
    }


    //Die Aktualisierung des Filters wird jedes Mal durchgeführt, wenn eine Box angeklickt wird
    //Dafür wird die Funktion _filterAktualisieren verwendet
    void _filterAktualisieren() {

      //Die Funktion funktionert hier genau wie für die ZutatenBox oben, nur für die FilterBox
      if (boxFilter.length != 0) {
        //Die filterBox_id ist der index + 1, da bei den zutat_ids 1 beim Erstellen angefangen wurde
        //Die aktuelle id wird in nummerZutatFilter festgehalten
        nummerZutatFilter = widget.index + 1;
        for (var i = 0; i < boxFilter.length; i++) {
          //Aktuelle Zutat zuweisen
          var zutatFilter = boxFilter.getAt(i);
          // Abspeichern, falls die zutat_id passt
          if (nummerZutatFilter == zutatFilter.boxFilter_id) {
            aktuelleZutatFilter = zutatFilter;
            //Platz in FilterBox speichern
            zutatidFilter = i;
            //Abbrechen der Schleife falls wahr
            break;
          }
        }
      } else {
        //nichts
        }
    }


    @override
    Widget build(BuildContext context) {
      //Flipschalter bauen
      return FilterChip(

        //Label des Buttons ist die aktuelle Zutat
        label: Text(aktuelleZutat.zutat),
        selected: gefiltert,

        //Wenn der Button ausgewählt wird:
        onSelected: (bool value) {

          //Der Filter muss aktualisiert werden
          _filterAktualisieren();

          //Ist das Item schon im Filter gewesen, wird es nun beim abwählen daraus gelöscht
          if (gefiltert == true) {
            boxFilter.deleteAt(zutatidFilter);

          } else {
            //Ist das Item nicht gewählt gewesen, wird es in die Filter-Box gespeichert
            boxFilter.put(aktuelleZutat.zutat, databaseBoxFilter(
                boxFilter_id: aktuelleZutat.zutat_id,
                boxFilterZutat: aktuelleZutat.zutat),
            );
          };

          //Invertieren des aktuellen Zustands beim Anklicken des Buttons
          setState(() {
            gefiltert = !gefiltert;
          }
          );
          },

        //Der Button soll nach dem Auswählen wie folgt aussehen:
        selectedColor: yellowToneDark,
        //Der Button der nicht Ausgewählt ist, soll wie folgt aussehen:
        backgroundColor: yellowToneLight,

        //Text Styling
        labelStyle: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15.00,
          fontFamily: 'Rooney',),
      );
    }
  }