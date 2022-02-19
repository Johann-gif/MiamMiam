import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../data/models/recepe_model.dart';
import '../image/image.dart';



class Recherche extends StatefulWidget {
  const Recherche({Key? key}) : super(key: key);

  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  CollectionReference recepes =
  FirebaseFirestore.instance.collection('recepes');


  final ScrollController _scrollController = ScrollController();
  bool init = false;
  var _query = '';
  bool isSearchEmpty = true;
  List<Map<String,String>> _selectedItems = [];
  bool rechercheParType = false;
  List<String> typesQuery = [];
  List<RecepeModel> _recettes = [];

 List<Map<String,String>> types = [
  {
    'id':'plat',
    'title':'Plat',
  },
   {
     'id':'entree',
     'title':'Entrée'
   },
   {
     'id':'dessert',
     'title':'Dessert'
   }
 ];
  void _itemChange(Map<String,String>  itemValue, bool isSelected) {
    print(itemValue);
    print(isSelected);
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
      print(_selectedItems);
    });
  }
void filterSearchRecette(){

    setState(() {
      isSearchEmpty = _query.isEmpty;
      typesQuery = [];
      init = false;
      _recettes = [];
    });
    print(_query);
      getRecette();


}

  void getRecette() async {

    List<RecepeModel> list = [];
    for (var i = 0; i < _selectedItems.length; i++) {
      typesQuery.add(_selectedItems[i]['id']!);
    }
    Query querySnapshot = recepes;
    if(typesQuery.isNotEmpty ){
    querySnapshot = querySnapshot.where('tags', arrayContainsAny: typesQuery);
    }
    if (!isSearchEmpty){
      querySnapshot = querySnapshot.where("title",isEqualTo: _query);
    }
    final QuerySnapshot result = await querySnapshot.get() ;
    for (var doc in result.docs) {
      list.add(RecepeModel.fromMap(doc));
    }
    setState(() {
      _recettes = list;
      init = true;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels +
          MediaQuery.of(context).size.height * 0.30 >=
          _scrollController.position.maxScrollExtent) {
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
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
              Text('types',
                  style: GoogleFonts.mochiyPopOne(
                    color: Colors.orange,
                    fontSize: 15,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              TextField(
            //controller: editingController,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
                labelText: "Rechercher",
                hintText: "Tartiflette ...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          )
        ),
        ListBody(
          children: types
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item['title'].toString()),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  filterSearchRecette();
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
        // const Divider(
        //   height: 30,
        // ),
        // display selected items

          Wrap(
            children: _selectedItems
                .map((e) => Chip(
              label: Text(e['title'].toString()),
            ))
                .toList(),
          ),
        !init
        ?Expanded(child: Lottie.asset("assets/food.json"))
            : Expanded(
            child: Stack(children: [
              ListView.separated(
                itemCount: _recettes.length,
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(_recettes[index].title!,
                          style: GoogleFonts.roboto(
                            color: CupertinoColors.black,
                            fontSize: 10,
                          )),
                      leading: Image.network(_recettes[index].image_url!
                          ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyImage()));
                      }
                    // action
                  );
                },
              ),
            ]))
      ],),

    );
  }
}
