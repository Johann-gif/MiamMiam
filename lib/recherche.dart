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

  bool _isAdultOn = false;
  final ScrollController _scrollController = ScrollController();
  bool loading = false;
  bool allLoaded = false;
  bool init = false;
  var _genreQuery = '';
  var _query = '';
  bool genreOk = false;
  bool rechercheParGenre = false;


  bool _isStartersOn = false;
  bool _isDishesOn = false;
  bool _isDesertsOn = false;
  bool _isSearchEmpty = true;

  final duplicateItems = List<String>.generate(10, (i) => "Item $i");

  void filterSearchResults() {
    setState(() {
      init = false;
      loading = true;
      _genreQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        // check box select
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
        Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text('+18',
                      style: GoogleFonts.roboto(
                        color: CupertinoColors.black,
                        fontSize: 15,
                      )),
                ),
              ),
            ])),

        !init
            ? Expanded(child: Lottie.asset("assets/the-panda-eats-popcorn.json"))
            : Expanded(
            child: Stack(children: [
              ListView.separated(
                itemCount: _films.length,
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(_films[index].title!,
                          style: GoogleFonts.roboto(
                            color: CupertinoColors.black,
                            fontSize: 10,
                          )),
                      leading: Image.network(_films[index].posterPath != null
                          ? 'https://image.tmdb.org/t/p/w500' +
                          _films[index].posterPath!
                          : 'https://i.imgur.com/R7mqXKL.png'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyImage(film: _films[index])));
                      }
                    // action
                  );
                },
              ),
              if (loading) ...[
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      height: 80,
                      child: Center(child: CircularProgressIndicator())),
                ),
              ]
            ]))
      ],
      ),
    );
  }
}
