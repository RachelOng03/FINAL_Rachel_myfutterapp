
//Importieren der relevanten Dart-Files
import 'package:flutter/material.dart';
import 'package:myfutterapp/constant.dart';
import 'package:myfutterapp/rezeptcreate.dart';
import 'package:myfutterapp/filter.dart';


class Footer extends StatefulWidget {
  Footer();
  @override
  _Footer createState() => _Footer();
}


class _Footer extends State<Footer>{

  @override
  Widget build(BuildContext context){
    return Container(
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
                primary: yellowText,),

              onPressed: () {
                Navigator.of(context).push (MaterialPageRoute(builder: (context) => Rezeptcreate()),);
              },
              label: Text('Rezepte teilen',style: TextStyle (color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.00, fontFamily: 'Rooney',),),
              icon: Icon(Icons.add, color: Colors.white,),
              ),
            ),
        ],
          //Button zum Erstellen eigener Rezepte hin (ausgegraut hier weil wir auf der Seite sind)
      ),
    );
  }
}
