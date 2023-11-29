
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:myfutterapp/Uebersichtsseite.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/footer.dart';
import 'package:myfutterapp/databaseBoxRezepte.dart';
import 'package:myfutterapp/boxes.dart';
import 'package:myfutterapp/zutat.dart';
import 'package:myfutterapp/databaseBoxMapping.dart';
import 'package:myfutterapp/filter.dart';
import 'package:myfutterapp/leereEingabe.dart';

//Grundlegendes wieder wie Farbschema

class Rezeptcreate extends StatefulWidget {
   Rezeptcreate();
  @override
  _RezeptcreateState createState() => _RezeptcreateState();
}

class _RezeptcreateState extends State<Rezeptcreate> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _zutatenController = TextEditingController();
  final TextEditingController _zubereitungController = TextEditingController();
  final List<TextEditingController> _additionalTextControllers = [];
  bool _isShareButtonDisabled = true;
  // Zustand der Klasse der veränderbar ist

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _zutatenController.dispose();
    _zubereitungController.dispose();
    _additionalTextControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
  //Kontrolliert Texteingabefelder ob genutzt - sonst wieder Freigabe der Ressourcen

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _addIngredientField() {
    setState(() {
      _additionalTextControllers.add(TextEditingController());
    });
  }
  // einzelne Zutateneingabefelder weiter hinzufügen

  void _saveToDatabase() {

    //Wir schließen hier aus, dass leere Felder in die Datenbank gespielt werden, da dass zu einem Fehler führt
    if (_textController1.text.isEmpty ||  _textController2.text.isEmpty || _zutatenController.text.isEmpty || _zubereitungController.text.isEmpty) {

      // Verweis darauf, dass die Eingabe leer ist
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => leereEingabe()),);

    } else {
      String title = _textController1.text;
      String preparationTime = _textController2.text;
      String ingredients = _zutatenController.text;
      List<String> additionalIngredients = _additionalTextControllers.map((
          controller) => controller.text).toList();
      String preparation = _zubereitungController.text;


      //Ab hier startet der Datenbankprozess

      //Hier werden die Rezepte in die Datenbank gespeichert
      boxRezepte.put('key_${title}', databaseBoxRezepte(
          rezepte_id: boxRezepte.length,
          rezepte_titel: title,
          rezepte_zeit: preparationTime,
          rezepte_anleitung: preparation),
      );

      // Schauen, ob alle Zutaten die eingegeben wurden, schon existieren
      // Ansonsten hinzufügen
      late bool inListe;
      late bool zutat1inListe;

      // Zutaten nur hinzufügen, wenn sie noch nicht existieren:

      // a) Für die erste Zutat:
      if (ingredients != null) {
        //Zutatenbox durchgehen
        for (var j = 0; j < boxZutat.length; j++) {
          Zutat aktZutat = boxZutat.getAt(j);

          // Falls die Zutat schon vorhanden ist
          if (ingredients == aktZutat.zutat) {
            zutat1inListe = true;
            //Abbrechen der Schleife falls die Zutat gefunden wurde
            break;
          } else {
            //Falls nicht vorhanden
            zutat1inListe = false;
          }
        }

        //Falls nicht vorhanden: Neue Zutat erstellen in der boxZutat
        if (zutat1inListe == false) {
          setState(() {
            boxZutat.put('key_${ingredients}',
              Zutat(zutat_id: boxZutat.length + 1, zutat: ingredients),);
          }
          );
        } else {
          //Sonst: Nichts, Zutat existiert schon
        }
      }


      // b) Selber Prozess für mehr als eine Zutat
      if (additionalIngredients != null) {
        //Anzahl der zusätzlichen Zutaten ermitteln
        for (var i = 0; i < additionalIngredients.length; i++) {
          //Aktuelle Zutat bestimmen
          String gewaehlt = additionalIngredients [i];

          //Alle Items der Zutatenbox durchgehen
          for (var j = 0; j < boxZutat.length; j++) {
            Zutat aktZutat = boxZutat.getAt(j);

            // Falls die Zutat schon vorhanden ist
            if (gewaehlt == aktZutat.zutat) {
              inListe = true;
              //Abbrechen der Schleife falls die Zutat gefunden wurde
              break;
            } else {
              //Falls nicht vorhanden
              inListe = false;
            }
          }

          // Falls nicht vorhanden: Neue Zutat erstellen in der boxZutat
          if (inListe == false) {
            setState(() {
              boxZutat.put('key_${additionalIngredients[i]}', Zutat(
                  zutat_id: boxZutat.length + 1,
                  zutat: additionalIngredients[i]),);
            }
            );
          } else {
            //Sonst: Nichts, Zutat existiert schon
          }
        }
      }


      //MAPPING der Rezepte zu den Zutaten
      late int rezepteFinden;

      //1. Richtige Poisition in der boxRezepte finden

      for (var i = 0; i < boxRezepte.length; i++) {
        //Aktuelles Rezept zuweisen
        var rezept = boxRezepte.getAt(i);
        // Abspeichern, falls der Titel passt
        if (title == rezept.rezepte_titel) {
          //Platz in der RezepteBox speichern
          rezepteFinden = rezept.rezepte_id;
          //Abbrechen der Schleife falls wahr
          break;
        }
      }


      //2. Zugehörige Zutaten aus der Zutatbox eintragen
      late int zutatgefundenID;

      // a) Erst 1. Zutat
      if (ingredients != null) {
        //Die ID für die Zutat finden
        for (var i = 0; i < boxZutat.length; i++) {
          //Aktuelle Zutat zuweisen
          Zutat zutat = boxZutat.getAt(i);
          // Abspeichern, falls die zutat_id passt
          if (ingredients == zutat.zutat) {
            zutatgefundenID = zutat.zutat_id;
            //Abbrechen der Schleife falls wahr
            break;
          }
        }

        //Hier wird das Mapping von Rezept & Zutat in die Datenbank gespeichert
        boxMapping.put('key_${boxMapping.length + 1}',
          databaseBoxMapping(
              mappingZutat_id: zutatgefundenID,
              mappingRezept_id: rezepteFinden),);


        // b) Selbe Schleife für die restlichen Zutaten des Rezepts

        late int eintragen;

        if (additionalIngredients != null) {
          //Anzahl zusätzliche Zutaten zählen
          for (var i = 0; i < additionalIngredients.length; i++) {
            //Aktuelle Zutat zuweisen
            String eintragen = additionalIngredients [i];

            //Zutatenbox durchgehen
            for (var j = 0; j < boxZutat.length; j++) {
              Zutat aktZutat = boxZutat.getAt(j);
              if (eintragen == aktZutat.zutat) {
                zutatgefundenID = aktZutat.zutat_id;
                break;
              }
            }

            //Hier wird das Mapping von Rezept & Zutat in die Datenbank gespeichert
            boxMapping.put('key_${boxMapping.length + 1}',
              databaseBoxMapping(
                  mappingZutat_id: zutatgefundenID,
                  mappingRezept_id: rezepteFinden),);
          }
        }

        // Prozess der Datenbankspeicherung abgeschlossen, zurückkehren zum Filter
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => filter()),);
      }
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowToneLight,

      appBar: AppBar(

        //Automatischen Pfeil entfernen
        automaticallyImplyLeading: false,

        toolbarHeight: 100,
        backgroundColor: yellowText,
        elevation: 0.0,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/Knoblauch.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Eigenes Rezept',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CooperBlack',
                    ),
                  ),
                  Text(
                    'erstellen',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CooperBlack',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/Zwiebel.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),

      //Definiert Eigenschaften der Appbar mit Bildern und Titel
      body: GestureDetector(
        onTap: _closeKeyboard,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController1,
                    //Länge-Eingabe begrenzen
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Titel',
                      filled: true,
                      fillColor: Colors.white,),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _textController2,
                    //Länge-Eingabe begrenzen
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: 'Zubereitungszeit',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _zutatenController,
                    //Länge-Eingabe begrenzen
                    maxLength: 12,
                    decoration: InputDecoration(
                      labelText: 'Zutat 1',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                //Definiert die Textfelder (Titel, Zubereitungszeit, Zutat 1)


                ..._additionalTextControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  TextEditingController controller = entry.value;
                  return Column(
                    children: [
                      SizedBox(height: 16),
                      Container(
                        width: 300,
                        child: TextField(
                          controller: controller,
                          maxLength: 12,
                          decoration: InputDecoration(
                            labelText: 'Zutat ${index + 2}',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                //Definiert die zusätzlich erstellten Eingabefelder für Zutaten

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _addIngredientField,
                  child: Text('Weitere Zutat hinzufügen', style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),
                  style: ElevatedButton.styleFrom(

                    primary: yellowText,
                  ),
                ),
                //Button zum Hinzufügen weiterer Zutatenfelder

                SizedBox(height: 16),

                Container(
                  width: 300,
                  child: TextField(
                    controller: _zubereitungController,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Zubereitung',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                //Definiert das Textfeld (Zubereitung)

                SizedBox(height: 16),

                Container(
                  width: 300,
                  padding: EdgeInsets.only(right: 0), // Legt den rechten Abstand fest
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _saveToDatabase,
                      child: Text('Teilen', style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),
                      style: ElevatedButton.styleFrom(
                        primary: yellowToneDark,
                      ),
                    ),
                  ),
                ),
                //Button zum Speichern in die Datenbank

                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),

      //Anderer Footer als sonst, da schon auf der Eingabeseite
      bottomNavigationBar:
      Container(
         color: Colors.white,
         height: 51.00,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Expanded(
               child: ElevatedButton.icon(
                 style: ElevatedButton.styleFrom(
                   fixedSize: Size.fromHeight(50.00),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(0.0),
                   ),
                   primary: yellowText,),
                 onPressed: () {
                   Navigator.of(context).push (MaterialPageRoute(builder: (context) => filter()),);
                 },
                 label: Text('Filter',style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.00, fontFamily: 'Rooney',),),
                 icon: Icon(Icons.home, color: Colors.white,),

               ),
             ),

             SizedBox(width: 2.00,),

             //Button zur Startseite hin
             Expanded(
               child: ElevatedButton.icon(
                 style: ElevatedButton.styleFrom(
                   fixedSize: Size.fromHeight(50.00),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(0.0),
                   ),
                   primary: darkGrey,),

                 onPressed: () {
                  // Nichts, da schon auf der Seite!
                  },
                 label: Text('Rezepte teilen',style: TextStyle (color: lightGrey, fontWeight: FontWeight.bold, fontSize: 17.00, fontFamily: 'Rooney',),),
                 icon: Icon(Icons.add, color: lightGrey,),
               ),
             ),
           ],
           //Button zum Erstellen eigener Rezepte hin (ausgegraut hier weil wir auf der Seite sind)
         ),
       ),
    );
  }
}
