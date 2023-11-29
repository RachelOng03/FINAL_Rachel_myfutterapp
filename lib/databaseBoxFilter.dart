
//In diesem File wird die Filter-Box erstellt

//Importieren der relevanten Dart-Files
import 'package:hive/hive.dart';

part 'databaseBoxFilter.g.dart';

@HiveType(typeId: 1)

//Die Box für die ausgewählten Zutaten im Filter
class databaseBoxFilter{

  //Jede Zutat in Filter besteht aus dem Namen der Zutat und der Id

  databaseBoxFilter ({
    required this.boxFilter_id,
    required this.boxFilterZutat
  });

  //Felder der Box anlegen:

  // Erstes Feld der Box
  @HiveField(0)
  int boxFilter_id;

  //Zweites Feld der Box
  @HiveField(1)
  String boxFilterZutat;
}