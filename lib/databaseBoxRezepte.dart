
//In dieser Box werden die Informationen über die einzelnen Rezepte gespeichert

//Importieren der relevanten Dart-Files
import 'package:hive/hive.dart';

part 'databaseBoxRezepte.g.dart';

@HiveType(typeId: 5)

// Die Box für die Rezepte
class databaseBoxRezepte {

  //Alle benötigten Daten für ein Rezept
  databaseBoxRezepte ({
    required this.rezepte_id,
    required this.rezepte_titel,
    required this.rezepte_zeit,
    required this.rezepte_anleitung,
  });

  // Felder der Box:

  @HiveField(0)
  int rezepte_id;

  @HiveField(1)
  String rezepte_titel;

  @HiveField(2)
  String rezepte_zeit;

  @HiveField(3)
  String rezepte_anleitung;

}