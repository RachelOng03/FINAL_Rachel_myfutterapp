
//Hier können bei Bedarf Zutaten zur Datenbank hinzugefügt oder entfernt werden.
//Außerdem ist dem Entwickler die Ausgabe der Boxen möglich.

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
import 'package:myfutterapp/Uebersichtsseite.dart';

class zutatDatabaseEditHive extends StatefulWidget {
  zutatDatabaseEditHive();
  @override
  _zutatEditDatabase createState() => _zutatEditDatabase();}

class _zutatEditDatabase extends State<zutatDatabaseEditHive>{

  //Der Wert aus dem Textfeld wird später die Zutat
  TextEditingController zutatController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: yellowToneLight,

      body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                SizedBox(height: 70.00,),

                // Zurück zur Übersichtsseite führen
                GestureDetector (onTap: () { Navigator.of(context).push (MaterialPageRoute(builder: (context) => ausgabe()),);},
                  child: Row(
                    children: [

                      SizedBox(width:50.00,),

                      Container (
                        //Gestaltung
                        height: 25.00, width: 220.00,
                        decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),
                        child: Center (
                          child: Text ("<< Zurück zur Übersicht", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),
                          ),
                        ),
                      ),

                      SizedBox(width:120.00,),
                   ],
                  ),
                ),

                SizedBox(height:20.00,),

                Container(

                  height: 60.00,
                  width: 320.00,

                  //Hier wird das Eingabefeld erstellt
                  child: TextField(
                      controller: zutatController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: darkGrey),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Zutat',
                      ),
                  ),
                ),

                SizedBox(height: 20.00,),

                //Bestätigung der Eingabe durch einen Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: yellowText,
                  fixedSize: Size(320.00, 50.00),
                  ),
                  //Wenn gedrückt:
                  onPressed: () {

                    //Löschen bestimmter Zutaten falls notwendig
                    //Nur einkommentieren, falls für den Entwickler notwendig
                    //Sonst auskommentiert

                    /* late int zutatidFilter;

                        for (var i = 0; i < boxZutat.length; i++) {
                          //Aktuelle Zutat zuweisen
                          var Loeschen = boxZutat.getAt(i);
                          // Abspeichern, falls die zutat_id passt
                          //Zutat id eingeben, die man löschen möchte
                          if (31 == Loeschen.zutat_id) {
                            //Platz in FilterBox speichern
                            zutatidFilter = i;
                            //Abbrechen der Schleife falls wahr
                            break;
                          }
                        }
                    setState(() {
                        boxZutat.deleteAt(zutatidFilter);
                    }); */


                    setState(() {
                      boxZutat.put ('key_${zutatController.text}', Zutat (zutat_id: boxZutat.length +1, zutat: zutatController.text),);
                    });


                    },


                  child: Text('Zutat eingeben', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.00, fontFamily: 'Rooney',),),
                   ),


                SizedBox(height: 20.00,),

                Text('Aktuelle Zutaten:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),


                //Existierende Zutaten werden ausgegeben
                Container(

                    //Stylen
                    height: 500.00,
                    width: 340.00,
                    decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                    //Ausgabe der Zutaten (Schleife wird wiederholt, bis alle einmal durch gegangen wurden)
                    child: ListView.builder(itemCount: boxZutat.length, itemBuilder: (context, index){

                      //Jeweilige Zutat aus der Box holen
                      Zutat zutat = boxZutat.getAt(index);

                      //Ausgabe: Zutat & Zutat_id
                      return ListTile(
                        title: Text(zutat.zutat),
                        subtitle: Text(zutat.zutat_id.toString()),
                    );

                }
                ),
                  ),

                // Nur zu Testzwecken;
                // Die Filterbox ausgeben lassen (selbes Vorgehen wie bei Zutaten)

                SizedBox(height: 30.00,),

                Text('Filter:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),

                Container(

                  //Stylen
                  height: 500.00,
                  width: 340.00,
                  decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                  child: ListView.builder(itemCount: boxFilter.length, itemBuilder: (context, index){
                    databaseBoxFilter lolfilter = boxFilter.getAt(index);

                    return ListTile(
                      title: Text(lolfilter.boxFilterZutat),
                      subtitle: Text(lolfilter.boxFilter_id.toString()),
                    );
                  }
                  ),
                ),


                //Rezepte ausgeben lassen
                SizedBox(height: 30.00,),

                Text('Rezepte:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),

                Container(

                  //Stylen
                  height: 500.00,
                  width: 340.00,
                  decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                  child: ListView.builder(itemCount: boxRezepte.length, itemBuilder: (context, index){
                    databaseBoxRezepte rezepte = boxRezepte.getAt(index);

                    return ListTile(
                      title: Text(rezepte.rezepte_titel),
                      subtitle: Column(
                        children: [
                        Text(rezepte.rezepte_id.toString()),
                        Text(rezepte.rezepte_zeit),
                        Text(rezepte.rezepte_anleitung),
                      ]
                      ),
                    );
                  }
                  ),
                ),

                //Mapping ausgeben lassen

                SizedBox(height: 20.00,),

                Text('Mapping:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),

                Container(

                  //Stylen
                  height: 500.00,
                  width: 340.00,
                  decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                  child: ListView.builder(itemCount: boxMapping.length, itemBuilder: (context, index){
                    databaseBoxMapping map = boxMapping.getAt(index);

                    return ListTile(
                      subtitle: Column(
                          children: [
                            Text(map.mappingZutat_id.toString()),
                            Text(map.mappingRezept_id.toString()),
                          ]
                      ),
                    );
                  }
                  ),
                ),

                //Gefilterte Rezepte ausgeben lassen.

                SizedBox(height: 20.00,),

                Text('Gefilterte Rezepte:',style: TextStyle(color: darkGrey, fontWeight: FontWeight.bold, fontSize: 20.0, fontFamily: 'Rooney',),),

                SizedBox(height: 10.00,),

                Container(

                  //Stylen
                  height: 500.00,
                  width: 340.00,
                  decoration: BoxDecoration (color: yellowToneDark, borderRadius: BorderRadius.circular(20)),

                  child: ListView.builder(itemCount: boxGefilterteRezepte.length, itemBuilder: (context, index){
                    databaseBoxRezepteGefiltert ausgabe = boxGefilterteRezepte.getAt(index);

                    return ListTile(
                      title: Text(ausgabe.gefilterteRezepte_id.toString())

                      );
                  }
                  ),
                  ),

                SizedBox(height: 30.00,),


              ],
            ),
          ),
      ),
      //Footer (ausgelagert)
      bottomNavigationBar: Footer(),
    );
  }
}