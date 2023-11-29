
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:myfutterapp/filterWidget.dart';
import 'package:myfutterapp/filterErgebnisse.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/header.dart';
import 'package:myfutterapp/rezeptcreate.dart';

class filter extends StatefulWidget {
  final String title = 'MyFutterApp';
  filter();
  @override
  State<filter> createState() => _filter();
}

class _filter extends State<filter> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowToneLight,

      // Header
      appBar: AppBar(

        // Automatischen Pfeil entfernen
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        elevation: 0.0,
        backgroundColor: yellowText,

        title: header(title: widget.title,),
      ),

      // Body
      body:
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  'Womit kochen wir heute?',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),

                //Erstellung der Filterergebnisse und FilterChips
                filterErgebnisse(),

              ],
            ),
          ),
        ),

      // Footer, allerdings ist Filterseite hier nicht responsive / ausgegraut, da sich der User bereits auf der Seite befindet
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
                  primary: darkGrey,),
                onPressed: () {
                  // Nichts, da schon auf der Seite!
                },
                label: Text('Filter',style: TextStyle (color: lightGrey, fontWeight: FontWeight.bold, fontSize: 17.00, fontFamily: 'Rooney',),),
                icon: Icon(Icons.home, color: lightGrey,),

              ),
            ),

            SizedBox(width: 2.00,),

            //Button zur Seite zum Erstellen eigener Rezepte
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(50.00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  primary: yellowText,),

                onPressed: () {
                  Navigator.of(context).push (MaterialPageRoute(builder: (context) => Rezeptcreate()),);
                },
                label: Text('Rezepte teilen',style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.00, fontFamily: 'Rooney',),),
                icon: Icon(Icons.add, color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
