import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  bool _isStartersOn = false;
  bool _isDishesOn = false;
  bool _isDesertsOn = false;
  bool _isSearchEmpty = true;

  final duplicateItems = List<String>.generate(10, (i) => "Item $i");

  void filterSearchResults(String query) {
    setState(() {
      _isSearchEmpty = query.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: !rechercheParGenre
              ? TextField(
            //controller: editingController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
                labelText: "Rechercher",
                hintText: "Matrix 2...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // use this button to open the multi-select dialog
              ElevatedButton(
                child: const Text('Selectionner un genre'),
                onPressed: _showMultiSelect,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
                child: !rechercheParGenre
                    ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      rechercheParGenre = !rechercheParGenre;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25.0))),
                  ),
                  child: const Text('Rechercher par genres'),
                )
                    : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      rechercheParGenre = !rechercheParGenre;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(25.0))),
                  ),
                  child: const Text('Rechercher par texte'),
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.025,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  filterSearchResults();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
                child: const Text('Rechercher'),
              ),
            )
          ]),
        ),
      ],
      ),
    );
  }
}
