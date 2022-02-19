import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Recherche extends StatelessWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        //Center(child: Text("Recherche")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rechercher par ',
                  style: GoogleFonts.mochiyPopOne(
                    color: CupertinoColors.black,
                    fontSize: 15,
                  )),
              Text('texte',
                  style: GoogleFonts.mochiyPopOne(
                    color: Colors.orange,
                    fontSize: 15,
                  )),
              Text(' ou par ',
                  style: GoogleFonts.mochiyPopOne(
                    color: CupertinoColors.black,
                    fontSize: 15,
                  )),
              Text('genre',
                  style: GoogleFonts.mochiyPopOne(
                    color: Colors.orange,
                    fontSize: 15,
                  ))
            ],
          ),
        ),
        Expanded(child: Lottie.asset("assets/food.json"))
      ],)
    );
  }
}
