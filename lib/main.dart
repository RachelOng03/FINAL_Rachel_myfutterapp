
//Finale Version
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfutterapp/boxes.dart';
import 'package:myfutterapp/filter.dart';


//Importiere aller Adapter für die Boxen
import 'package:myfutterapp/zutat.dart';
import 'package:myfutterapp/databaseBoxFilter.dart';
import 'package:myfutterapp/databaseBoxMapping.dart';
import 'package:myfutterapp/databaseBoxRezepteGefiltert.dart';
import 'package:myfutterapp/databaseBoxRezepte.dart';
import 'package:myfutterapp/databaseBoxAehnlich.dart';
import 'package:myfutterapp/zutatDatabaseEditHive.dart';
import 'package:myfutterapp/filter.dart';
import 'package:myfutterapp/startseite.dart';

//Nur falls nachträgliche Datenbank-Bearbeitung erforderlich
import 'package:myfutterapp/zutatDatabaseEditHive.dart';

//Main laufen lassen
void main() async{

  //Hier werden die Datenbank Boxen angelegt.

  //Hive initialisieren
  await Hive.initFlutter();

  // 1. Zutaten speichern
  //Adapter für Zutaten
  Hive.registerAdapter(ZutatAdapter());
  // Box Zutat aufmachen
  boxZutat = await Hive.openBox<Zutat>('zutatBox');


  // 2. Filter initial einstellen
  //Die Filterbox enthält genau zutaten_id & zutat wie in 1., aber nur von den Items, die gerade ausgewählt sind.
  //Adapter für databaseBoxFilter
  Hive.registerAdapter(databaseBoxFilterAdapter());
  //Box-Filter aufmachen
  boxFilter = await Hive.openBox<databaseBoxFilter>('databaseBoxFilterBox');
  //Filterbox initial leeren (keine Filter aus letzter Benutzung der App)
  await boxFilter.clear();


  // 3. Adapter für databaseBoxMapping
  Hive.registerAdapter(databaseBoxMappingAdapter());
  //Box Mapping aufmachen
  boxMapping= await Hive.openBox<databaseBoxMapping>('databaseBoxMappingBox');


  // 4. Adapter für die gefilterten Rezept, alle Rezepte die passen werden hier rein gespeichert
  Hive.registerAdapter(databaseBoxRezepteGefiltertAdapter());
  // Box GefilterteRezepte aufmachen
  boxGefilterteRezepte = await Hive.openBox<databaseBoxRezepteGefiltert>('databaseBoxRezepteGefiltert');
  //Diese Box initial leeren (keine Filter aus letzter Benutzung der App)
  await boxGefilterteRezepte.clear();


  // 5. Adapter für die Rezepte
  Hive.registerAdapter(databaseBoxRezepteAdapter());
  // Box Rezepte aufmachen
  boxRezepte = await Hive.openBox<databaseBoxRezepte>('databaseBoxRezepte');

  // 6. Adapter für ähnliche Rezepte
  Hive.registerAdapter(databaseBoxAehnlichAdapter());
  // Box Ähnlich aufmachen
  boxAehnlich = await Hive.openBox<databaseBoxAehnlich>('databaseBoxAehnlich');

  // Bei Bedarf könnten hier alle Rezepte gelöschen werden.
  // await boxRezepte.clear();
  // await boxMapping.clear();

  //App laufen lassen
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFutterApp',

      //Der Home Bildschirm soll mit der Startseite Page gefüllt werden.
      home: MyHomePage(title: ' MyFutterApp ',),
    );
  }
}