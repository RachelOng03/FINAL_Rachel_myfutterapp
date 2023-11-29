
//In diesem File wird die Zutat-Box erstellt

//Importieren der relevanten Dart-Files
import 'package:hive/hive.dart';

part 'zutat.g.dart';

@HiveType(typeId: 3)

//Eine Box "Zutat" wird erstellt
class Zutat {

  //Sowohl Zutat als auch zutat_id müssen immer ausgefüllt sein (required)
  Zutat({required this.zutat_id,
    required this.zutat});

  // Erstes Feld der Box
  @HiveField(0)
  int zutat_id;

  //Zweites Feld der Box
  @HiveField(1)
  String zutat;
}