import 'package:flutter/material.dart';

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
          child: TextField(
            //controller: editingController,
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
                labelText: "Rechercher",
                hintText: "Quiche loraine...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
      ],
      ),
    );
  }
}
