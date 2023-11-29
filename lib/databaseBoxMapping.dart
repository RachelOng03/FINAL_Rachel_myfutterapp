
//In diesem File wird die Mapping-Box für Zutaten zu Rezepten erstellt

//Importieren der relevanten dart-Files
import 'package:hive/hive.dart';

part 'databaseBoxMapping.g.dart';

@HiveType(typeId: 2)

//Die Box für die Zuordnung von Rezepten zu den Zutaten
class databaseBoxMapping{

  //Die Zutat-id wird der jeweiligen Rezept-Id zugeordnet
  //Beide sind required (dürfen nicht undefiniert sein)
  databaseBoxMapping ({
    required this.mappingZutat_id,
    required this.mappingRezept_id
  });

  //Felder der Box anlegen:

  // Erstes Feld der Box
  @HiveField(0)
  int mappingZutat_id;

  //Zweites Feld der Box
  @HiveField(1)
  int mappingRezept_id;
}